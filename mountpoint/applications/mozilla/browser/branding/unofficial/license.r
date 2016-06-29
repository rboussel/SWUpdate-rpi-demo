// See /System/Library/Frameworks/CoreServices.framework/Frameworks/CarbonCore.framework/Headers/Script.h for language IDs.
data 'LPic' (5000) {
  // Default language ID, 0 = English
  $"0000"
  // Number of entries in list
  $"0001"

  // Entry 1
  // Language ID, 0 = English
  $"0000"
  // Resource ID, 0 = STR#/TEXT/styl 5000
  $"0000"
  // Multibyte language, 0 = no
  $"0000"
};

resource 'STR#' (5000, "English") {
  {
    // Language (unused?) = English
    "English",
    // Accept (Agree)
    "Accept",
    // Decline (Disagree)
    "Decline",
    // Print, ellipsis is 0xC9
    "Print…",
    // Save As, ellipsis is 0xC9
    "Save As…",
    // Descriptive text, curly quotes are 0xD2 and 0xD3
    "You are about to install\n"
    "Gran Paradiso.\n"
    "\n"
    "Please read the license agreement.  If you agree to its terms and accept, click “Accept” to access the software.  Otherwise, click “Decline” to cancel."
  };
};

// Beware of 1024(?) byte (character?) line length limitation.  Split up long
// lines.
// If straight quotes are used ("), remember to escape them (\").
// Newline is \n, to leave a blank line, use two of them.
// 0xD2 and 0xD3 are curly double-quotes ("), 0xD4 and 0xD5 are curly
//   single quotes ('), 0xD5 is also the apostrophe.
data 'TEXT' (5000, "English") {
/*  "GRAN PARADISO END-USER SOFTWARE LICENSE AGREEMENT\n"
  "Version 3.0, May 2008\n"
  "\n"
  "A SOURCE CODE VERSION OF CERTAIN FIREFOX BROWSER FUNCTIONALITY THAT YOU MAY USE, MODIFY AND DISTRIBUTE IS AVAILABLE TO YOU FREE-OF-CHARGE FROM WWW.MOZILLA.ORG UNDER THE MOZILLA PUBLIC LICENSE and other open source software licenses.\n"
  "\n"
  "The accompanying executable code version of Mozilla Firefox and related documentation (the “Product”) is made available to you under the terms of this MOZILLA FIREFOX END-USER SOFTWARE LICENSE AGREEMENT (THE “AGREEMENT”).  BY CLICKING THE “ACCEPT” BUTTON, OR BY INSTALLING OR USING THE MOZILLA FIREFOX BROWSER, YOU ARE CONSENTING TO BE BOUND BY THE AGREEMENT.  IF YOU DO NOT AGREE TO THE TERMS AND CONDITIONS OF THIS AGREEMENT, DO NOT CLICK THE “ACCEPT” BUTTON, AND DO NOT INSTALL OR USE ANY PART OF THE MOZILLA FIREFOX BROWSER.\n"
  "\n"
  "DURING THE MOZILLA FIREFOX INSTALLATION PROCESS, AND AT LATER TIMES, YOU MAY BE GIVEN THE OPTION OF INSTALLING ADDITIONAL COMPONENTS FROM THIRD-PARTY SOFTWARE PROVIDERS.  THE INSTALLATION AND USE OF THOSE THIRD-PARTY COMPONENTS MAY BE GOVERNED BY ADDITIONAL LICENSE AGREEMENTS.\n"
  "\n"
  "1.  LICENSE GRANT.  The Mozilla Corporation grants you a non-exclusive license to use the executable code version of the Product.  This Agreement will also govern any software upgrades provided by Mozilla that replace and/or supplement the original Product, unless such upgrades are accompanied by a separate license, in which case the terms of that license will govern.\n"
  "\n"
  "2.  TERMINATION.  If you breach this Agreement your right to use the Product will terminate immediately and without notice, but all provisions of this Agreement except the License Grant (Paragraph 1) will survive termination and continue in effect.  Upon termination, you must destroy all copies of the Product.\n"
  "\n"
  "3.  PROPRIETARY RIGHTS.  Portions of the Product are available in source code form under the terms of the Mozilla Public License and other open source licenses (collectively, “Open Source Licenses”) at http://www.mozilla.org/MPL.  Nothing in this Agreement will be construed to limit any rights granted under the Open Source Licenses.  Subject to the foregoing, Mozilla, for itself and on behalf of its licensors, hereby reserves all intellectual property rights in the Product, except for the rights expressly granted in this Agreement.  You may not remove or alter any trademark, logo, copyright or other proprietary notice in or on the Product.  This license does not grant you any right to use the trademarks, service marks or logos of Mozilla or its licensors.\n"
  "\n"
  "4.  PRIVACY POLICY.  You agree to the Mozilla Firefox Privacy Policy, made available online at http://www.mozilla.com/legal/privacy/, as that policy may be changed from time to time.  When Mozilla changes the policy in a material way a notice will be posted on the website at www.mozilla.com and when any change is made in the privacy policy, the updated policy will be posted at the above link.  It is your responsibility to ensure that you understand the terms of the privacy policy, so you should periodically check the current version of the policy for changes.\n"
  "\n"
  "5.  WEBSITE INFORMATION SERVICES.  Mozilla and its contributors, licensors and partners work to provide the most accurate and up-to-date phishing and malware information.  However, they cannot guarantee that this information is comprehensive and error-free: some risky sites may not be identified, and some safe sites may be identified in error.\n"
  "\n"
  "6.  DISCLAIMER OF WARRANTY.  THE PRODUCT IS PROVIDED “AS IS” WITH ALL FAULTS.  TO THE EXTENT PERMITTED BY LAW, MOZILLA AND MOZILLA’S DISTRIBUTORS, AND LICENSORS HEREBY DISCLAIM ALL WARRANTIES, WHETHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION WARRANTIES THAT THE PRODUCT IS FREE OF DEFECTS, MERCHANTABLE, FIT FOR A PARTICULAR PURPOSE AND NON-INFRINGING.  YOU BEAR THE ENTIRE RISK AS TO SELECTING THE PRODUCT FOR YOUR PURPOSES AND AS TO THE QUALITY AND PERFORMANCE OF THE PRODUCT.  THIS LIMITATION WILL APPLY NOTWITHSTANDING THE FAILURE OF ESSENTIAL PURPOSE OF ANY REMEDY.  SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OR LIMITATION OF IMPLIED WARRANTIES, SO THIS DISCLAIMER MAY NOT APPLY TO YOU.\n"
  "\n"
  "7.  LIMITATION OF LIABILITY.  EXCEPT AS REQUIRED BY LAW, MOZILLA AND ITS DISTRIBUTORS, DIRECTORS, LICENSORS, CONTRIBUTORS AND AGENTS (COLLECTIVELY, THE “MOZILLA GROUP”) WILL NOT BE LIABLE FOR ANY INDIRECT, SPECIAL, INCIDENTAL, CONSEQUENTIAL OR EXEMPLARY DAMAGES ARISING OUT OF OR IN ANY WAY RELATING TO THIS AGREEMENT OR THE USE OF OR INABILITY TO USE THE PRODUCT, INCLUDING WITHOUT LIMITATION DAMAGES FOR LOSS OF GOODWILL, WORK STOPPAGE, LOST PROFITS, LOSS OF DATA, AND COMPUTER FAILURE OR MALFUNCTION, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGES AND REGARDLESS OF THE THEORY (CONTRACT, TORT OR OTHERWISE) UPON WHICH SUCH CLAIM IS BASED.  THE MOZILLA GROUP’S COLLECTIVE LIABILITY UNDER THIS AGREEMENT WILL NOT EXCEED THE GREATER OF $500 (FIVE HUNDRED DOLLARS) AND THE FEES PAID BY YOU UNDER THE LICENSE (IF ANY).  SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OR LIMITATION OF INCIDENTAL, CONSEQUENTIAL OR SPECIAL DAMAGES, SO THIS EXCLUSION AND LIMITATION MAY NOT APPLY TO YOU.\n"
  "\n"
  "8.  EXPORT CONTROLS.  This license is subject to all applicable export restrictions.  You must comply with all export and import laws and restrictions and regulations of any United States or foreign agency or authority relating to the Product and its use.\n"
  "\n"
  "9.  U.S. GOVERNMENT END-USERS.  This Product is a “commercial item,” as that term is defined in 48 C.F.R. 2.101, consisting of “commercial computer software” and “commercial computer software documentation,” as such terms are used in 48 C.F.R. 12.212 (Sept. 1995) and 48 C.F.R. 227.7202 (June 1995).  Consistent with 48 C.F.R. 12.212, 48 C.F.R. 27.405(b)(2) (June 1998) and 48 C.F.R. 227.7202, all U.S. Government End Users acquire the Product with only those rights as set forth therein.\n"
  "\n"
  "10.  MISCELLANEOUS.  (a) This Agreement constitutes the entire agreement between Mozilla and you concerning the subject matter hereof, and it may only be modified by a written amendment signed by an authorized executive of Mozilla.  (b) Except to the extent applicable law, if any, provides otherwise, this Agreement will be governed by the laws of the state of California, U.S.A., excluding its conflict of law provisions.  (c) This Agreement will not be governed by the United Nations Convention on Contracts for the International Sale of Goods.  "
  "(d) If any part of this Agreement is held invalid or unenforceable, that part will be construed to reflect the parties’ original intent, and the remaining portions will remain in full force and effect.  (e) A waiver by either party of any term or condition of this Agreement or any breach thereof, in any one instance, will not waive such term or condition or any subsequent breach thereof. (f) Except as required by law, the controlling language of this Agreement is English.  "
  "(g) You may assign your rights under this Agreement to any party that consents to, and agrees to be bound by, its terms; the Mozilla Corporation may assign its rights under this Agreement without condition.  (h) This Agreement will be binding upon and inure to the benefit of the parties, their successors and permitted assigns."
  */
"GNU GENERAL PUBLIC LICENSE\n"
"\n"
"Version 2, June 1991\n"
"\n"
"Copyright (C) 1989, 1991 Free Software Foundation, Inc.  \n"
"51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA\n"
"\n"
"Everyone is permitted to copy and distribute verbatim copies\n"
"of this license document, but changing it is not allowed.\n"
"\n"
"Preamble\n"
"\n"
"The licenses for most software are designed to take away your freedom to share and change it. By contrast, the GNU General Public License is intended to guarantee your freedom to share and change free software--to make sure the software is free for all its users. This General Public License applies to most of the Free Software Foundation's software and to any other program whose authors commit to using it. (Some other Free Software Foundation software is covered by the GNU Lesser General Public License instead.) You can apply it to your programs, too.\n"
"\n"
"When we speak of free software, we are referring to freedom, not price. Our General Public Licenses are designed to make sure that you have the freedom to distribute copies of free software (and charge for this service if you wish), that you receive source code or can get it if you want it, that you can change the software or use pieces of it in new free programs; and that you know you can do these things.\n"
"\n"
"To protect your rights, we need to make restrictions that forbid anyone to deny you these rights or to ask you to surrender the rights. These restrictions translate to certain responsibilities for you if you distribute copies of the software, or if you modify it.\n"
"\n"
"For example, if you distribute copies of such a program, whether gratis or for a fee, you must give the recipients all the rights that you have. You must make sure that they, too, receive or can get the source code. And you must show them these terms so they know their rights.\n"
"\n"
"We protect your rights with two steps: (1) copyright the software, and (2) offer you this license which gives you legal permission to copy, distribute and/or modify the software.\n"
"\n"
"Also, for each author's protection and ours, we want to make certain that everyone understands that there is no warranty for this free software. If the software is modified by someone else and passed on, we want its recipients to know that what they have is not the original, so that any problems introduced by others will not reflect on the original authors' reputations.\n"
"\n"
"Finally, any free program is threatened constantly by software patents. We wish to avoid the danger that redistributors of a free program will individually obtain patent licenses, in effect making the program proprietary. To prevent this, we have made it clear that any patent must be licensed for everyone's free use or not licensed at all.\n"
"\n"
"The precise terms and conditions for copying, distribution and modification follow.\n"
"TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION\n"
"\n"
"0. This License applies to any program or other work which contains a notice placed by the copyright holder saying it may be distributed under the terms of this General Public License. The \"Program\", below, refers to any such program or work, and a \"work based on the Program\" means either the Program or any derivative work under copyright law: that is to say, a work containing the Program or a portion of it, either verbatim or with modifications and/or translated into another language. (Hereinafter, translation is included without limitation in the term \"modification\".) Each licensee is addressed as \"you\".\n"
"\n"
"Activities other than copying, distribution and modification are not covered by this License; they are outside its scope. The act of running the Program is not restricted, and the output from the Program is covered only if its contents constitute a work based on the Program (independent of having been made by running the Program). Whether that is true depends on what the Program does.\n"
"\n"
"1. You may copy and distribute verbatim copies of the Program's source code as you receive it, in any medium, provided that you conspicuously and appropriately publish on each copy an appropriate copyright notice and disclaimer of warranty; keep intact all the notices that refer to this License and to the absence of any warranty; and give any other recipients of the Program a copy of this License along with the Program.\n"
"\n"
"You may charge a fee for the physical act of transferring a copy, and you may at your option offer warranty protection in exchange for a fee.\n"
"\n"
"2. You may modify your copy or copies of the Program or any portion of it, thus forming a work based on the Program, and copy and distribute such modifications or work under the terms of Section 1 above, provided that you also meet all of these conditions:\n"
"\n"
    "a) You must cause the modified files to carry prominent notices stating that you changed the files and the date of any change. \n"
    "b) You must cause any work that you distribute or publish, that in whole or in part contains or is derived from the Program or any part thereof, to be licensed as a whole at no charge to all third parties under the terms of this License. \n"
    "c) If the modified program normally reads commands interactively when run, you must cause it, when started running for such interactive use in the most ordinary way, to print or display an announcement including an appropriate copyright notice and a notice that there is no warranty (or else, saying that you provide a warranty) and that users may redistribute the program under these conditions, and telling the user how to view a copy of this License. (Exception: if the Program itself is interactive but does not normally print such an announcement, your work based on the Program is not required to print an announcement.) \n"
"\n"
"These requirements apply to the modified work as a whole. If identifiable sections of that work are not derived from the Program, and can be reasonably considered independent and separate works in themselves, then this License, and its terms, do not apply to those sections when you distribute them as separate works. But when you distribute the same sections as part of a whole which is a work based on the Program, the distribution of the whole must be on the terms of this License, whose permissions for other licensees extend to the entire whole, and thus to each and every part regardless of who wrote it.\n"
"\n"
"Thus, it is not the intent of this section to claim rights or contest your rights to work written entirely by you; rather, the intent is to exercise the right to control the distribution of derivative or collective works based on the Program.\n"
"\n"
"In addition, mere aggregation of another work not based on the Program with the Program (or with a work based on the Program) on a volume of a storage or distribution medium does not bring the other work under the scope of this License.\n"
"\n"
"3. You may copy and distribute the Program (or a work based on it, under Section 2) in object code or executable form under the terms of Sections 1 and 2 above provided that you also do one of the following:\n"
"\n"
    "a) Accompany it with the complete corresponding machine-readable source code, which must be distributed under the terms of Sections 1 and 2 above on a medium customarily used for software interchange; or, \n"
    "b) Accompany it with a written offer, valid for at least three years, to give any third party, for a charge no more than your cost of physically performing source distribution, a complete machine-readable copy of the corresponding source code, to be distributed under the terms of Sections 1 and 2 above on a medium customarily used for software interchange; or, \n"
    "c) Accompany it with the information you received as to the offer to distribute corresponding source code. (This alternative is allowed only for noncommercial distribution and only if you received the program in object code or executable form with such an offer, in accord with Subsection b above.) \n"
"\n"
"The source code for a work means the preferred form of the work for making modifications to it. For an executable work, complete source code means all the source code for all modules it contains, plus any associated interface definition files, plus the scripts used to control compilation and installation of the executable. However, as a special exception, the source code distributed need not include anything that is normally distributed (in either source or binary form) with the major components (compiler, kernel, and so on) of the operating system on which the executable runs, unless that component itself accompanies the executable.\n"
"\n"
"If distribution of executable or object code is made by offering access to copy from a designated place, then offering equivalent access to copy the source code from the same place counts as distribution of the source code, even though third parties are not compelled to copy the source along with the object code.\n"
"\n"
"4. You may not copy, modify, sublicense, or distribute the Program except as expressly provided under this License. Any attempt otherwise to copy, modify, sublicense or distribute the Program is void, and will automatically terminate your rights under this License. However, parties who have received copies, or rights, from you under this License will not have their licenses terminated so long as such parties remain in full compliance.\n"
"\n"
"5. You are not required to accept this License, since you have not signed it. However, nothing else grants you permission to modify or distribute the Program or its derivative works. These actions are prohibited by law if you do not accept this License. Therefore, by modifying or distributing the Program (or any work based on the Program), you indicate your acceptance of this License to do so, and all its terms and conditions for copying, distributing or modifying the Program or works based on it.\n"
"\n"
"6. Each time you redistribute the Program (or any work based on the Program), the recipient automatically receives a license from the original licensor to copy, distribute or modify the Program subject to these terms and conditions. You may not impose any further restrictions on the recipients' exercise of the rights granted herein. You are not responsible for enforcing compliance by third parties to this License.\n"
"\n"
"7. If, as a consequence of a court judgment or allegation of patent infringement or for any other reason (not limited to patent issues), conditions are imposed on you (whether by court order, agreement or otherwise) that contradict the conditions of this License, they do not excuse you from the conditions of this License. If you cannot distribute so as to satisfy simultaneously your obligations under this License and any other pertinent obligations, then as a consequence you may not distribute the Program at all. For example, if a patent license would not permit royalty-free redistribution of the Program by all those who receive copies directly or indirectly through you, then the only way you could satisfy both it and this License would be to refrain entirely from distribution of the Program.\n"
"\n"
"If any portion of this section is held invalid or unenforceable under any particular circumstance, the balance of the section is intended to apply and the section as a whole is intended to apply in other circumstances.\n"
"\n"
"It is not the purpose of this section to induce you to infringe any patents or other property right claims or to contest validity of any such claims; this section has the sole purpose of protecting the integrity of the free software distribution system, which is implemented by public license practices. Many people have made generous contributions to the wide range of software distributed through that system in reliance on consistent application of that system; it is up to the author/donor to decide if he or she is willing to distribute software through any other system and a licensee cannot impose that choice.\n"
"\n"
"This section is intended to make thoroughly clear what is believed to be a consequence of the rest of this License.\n"
"\n"
"8. If the distribution and/or use of the Program is restricted in certain countries either by patents or by copyrighted interfaces, the original copyright holder who places the Program under this License may add an explicit geographical distribution limitation excluding those countries, so that distribution is permitted only in or among countries not thus excluded. In such case, this License incorporates the limitation as if written in the body of this License.\n"
"\n"
"9. The Free Software Foundation may publish revised and/or new versions of the General Public License from time to time. Such new versions will be similar in spirit to the present version, but may differ in detail to address new problems or concerns.\n"
"\n"
"Each version is given a distinguishing version number. If the Program specifies a version number of this License which applies to it and \"any later version\", you have the option of following the terms and conditions either of that version or of any later version published by the Free Software Foundation. If the Program does not specify a version number of this License, you may choose any version ever published by the Free Software Foundation.\n"
"\n"
"10. If you wish to incorporate parts of the Program into other free programs whose distribution conditions are different, write to the author to ask for permission. For software which is copyrighted by the Free Software Foundation, write to the Free Software Foundation; we sometimes make exceptions for this. Our decision will be guided by the two goals of preserving the free status of all derivatives of our free software and of promoting the sharing and reuse of software generally.\n"\n"
"\n"
"NO WARRANTY\n"
"\n"
"11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM \"AS IS\" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.\n"
"\n"
"12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.\n"
"END OF TERMS AND CONDITIONS\n"
"\n"
};

data 'styl' (5000, "English") {
  // Number of styles following = 2
  $"0002"

  // Style 1.  This is used to display the header lines in bold text.
  // Start character = 0
  $"0000 0000"
  // Height = 16
  $"0010"
  // Ascent = 12
  $"000C"
  // Font family = 1024 (Lucida Grande)
  $"0400"
  // Style bitfield, 0x1=bold 0x2=italic 0x4=underline 0x8=outline
  // 0x10=shadow 0x20=condensed 0x40=extended
  $"01"
  // Style, unused?
  $"02"
  // Size = 12 point
  $"000C"
  // Color, RGB
  $"0000 0000 0000"

  // Style 2.  This is used to display the body.
  // Start character = 72
  $"0000 0048"
  // Height = 16
  $"0010"
  // Ascent = 12
  $"000C"
  // Font family = 1024 (Lucida Grande)
  $"0400"
  // Style bitfield, 0x1=bold 0x2=italic 0x4=underline 0x8=outline
  // 0x10=shadow 0x20=condensed 0x40=extended
  $"00"
  // Style, unused?
  $"02"
  // Size = 12 point
  $"000C"
  // Color, RGB
  $"0000 0000 0000"
};
