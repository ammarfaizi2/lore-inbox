Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVEaSel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVEaSel (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 14:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVEaSeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 14:34:36 -0400
Received: from mail.dvmed.net ([216.237.124.58]:12930 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261172AbVEaSda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 14:33:30 -0400
Message-ID: <429CADF3.7080607@pobox.com>
Date: Tue, 31 May 2005 14:33:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Waitz <tali@admingilde.org>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: DocBook build failures, and graphical figures
References: <429CAD7B.5070301@pobox.com>
In-Reply-To: <429CAD7B.5070301@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------010601030209070403090401"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010601030209070403090401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> 
> Some DocBook-related comments and questions:
> 
> * "make psdocs" and "make pdfdocs" both fail in current tree, on Fedora 
> Core 2 (FC2) and Red Hat Enterprise Linux 4 (RHEL4).  Strangely enough, 
> they fail on different files.  I've attached output-psdocs.txt and 
> output-pdfdocs.txt showing the errors I get.

Sigh.  Forgot the attachments.

Also, an additional detail:  "make mandocs" and "make htmldocs" work 
fine, for all files.

	Jeff




--------------010601030209070403090401
Content-Type: text/plain;
 name="output-pdfdocs.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="output-pdfdocs.txt"

  XMLTO   Documentation/DocBook/kernel-locking.pdf
Making portrait pages on USletter paper (8.5inx11in)
This is pdfTeX, Version 3.14159-1.10b (Web2C 7.4.5)
(./tmp.fo{/usr/share/texmf/pdftex/config/pdftex.cfg}
LaTeX2e <2001/06/01>
Babel <v3.7h> and hyphenation patterns for american, french, german, ngerman, n
ohyphenation, loaded.
xmltex version: 2002/06/25 v1.9 (Exp):
(/usr/share/texmf/tex/xmltex/xmltex.cfg) 
No File: tmp.cfg (/usr/share/texmf/tex/xmltex/passivetex/fotex.xmt)
(/usr/share/texmf/tex/latex/base/article.cls
Document Class: article 2001/04/21 v1.4e Standard LaTeX document class
(/usr/share/texmf/tex/latex/base/size10.clo))
(/usr/share/texmf/tex/xmltex/passivetex/fotex.sty
)
No file tmp.aux.
(/usr/share/texmf/tex/latex/cyrillic/t2acmr.fd)
(/usr/share/texmf/tex/latex/base/ts1cmr.fd)
(/usr/share/texmf/tex/latex/psnfss/t1ptm.fd)
No file tmp.out.
No file tmp.out.
INFO: Using normal, i.e. nonfrench-spacing in document
(/usr/share/texmf/tex/latex/psnfss/t1phv.fd)
(/usr/share/texmf/tex/latex/psnfss/t1pcr.fd) [1{/usr/share/texmf/dvips/config/p
dftex.map}] (/usr/share/texmf/tex/latex/psnfss/ts1ptm.fd) [2]
(/usr/share/texmf/tex/latex/amsfonts/umsa.fd)
(/usr/share/texmf/tex/latex/amsfonts/umsb.fd)
(/usr/share/texmf/tex/latex/wasysym/uwasy.fd)
(/usr/share/texmf/tex/latex/misc/ustmry.fd) [3] [4]

LaTeX Font Warning: Font shape `OT1/cmr/m/n' in size <12.44159> not available
(Font)              size <12> substituted on input line 465.


LaTeX Font Warning: Font shape `OML/cmm/m/it' in size <12.44159> not available
(Font)              size <12> substituted on input line 465.


LaTeX Font Warning: Font shape `OMS/cmsy/m/n' in size <12.44159> not available
(Font)              size <12> substituted on input line 465.


LaTeX Font Warning: Font shape `OMX/cmex/m/n' in size <12.44159> not available
(Font)              size <12> substituted on input line 465.


LaTeX Font Warning: Font shape `U/msa/m/n' in size <12.44159> not available
(Font)              size <12> substituted on input line 465.


LaTeX Font Warning: Font shape `U/msb/m/n' in size <12.44159> not available
(Font)              size <12> substituted on input line 465.


LaTeX Font Warning: Font shape `U/wasy/m/n' in size <12.44159> not available
(Font)              size <12> substituted on input line 465.


LaTeX Font Warning: Font shape `U/stmry/m/n' in size <12.44159> not available
(Font)              size <12> substituted on input line 465.

[1]
Overfull \hbox (21.5593pt too wide) in paragraph at lines 523--523
[]/phvb8t@24.8832pt/Chapter$ $2.$ $The Prob-lem With Con-cur-rency 

Overfull \hbox (16.4593pt too wide) in paragraph at lines 534--534
/ptmr8t/very_important_count 

Overfull \hbox (16.4593pt too wide) in paragraph at lines 534--534
/ptmr8t/very_important_count 

Overfull \hbox (16.4593pt too wide) in paragraph at lines 534--534
/ptmr8t/very_important_count 

Overfull \hbox (16.4593pt too wide) in paragraph at lines 534--534
/ptmr8t/very_important_count 

Overfull \hbox (16.4593pt too wide) in paragraph at lines 534--534
/ptmr8t/very_important_count 

Overfull \hbox (16.4593pt too wide) in paragraph at lines 534--534
/ptmr8t/very_important_count 

Overfull \hbox (16.4593pt too wide) in paragraph at lines 534--534
/ptmr8t/very_important_count 

Overfull \hbox (16.4593pt too wide) in paragraph at lines 534--534
/ptmr8t/very_important_count 

Overfull \hbox (16.4593pt too wide) in paragraph at lines 538--538
/ptmr8t/very_important_count 

Overfull \hbox (16.4593pt too wide) in paragraph at lines 538--538
/ptmr8t/very_important_count 

Overfull \hbox (16.4593pt too wide) in paragraph at lines 538--538
/ptmr8t/very_important_count 

Overfull \hbox (16.4593pt too wide) in paragraph at lines 538--538
/ptmr8t/very_important_count 

Overfull \hbox (16.4593pt too wide) in paragraph at lines 538--538
/ptmr8t/very_important_count 

Overfull \hbox (16.4593pt too wide) in paragraph at lines 538--538
/ptmr8t/very_important_count 

Overfull \hbox (16.4593pt too wide) in paragraph at lines 538--538
/ptmr8t/very_important_count 

Overfull \hbox (16.4593pt too wide) in paragraph at lines 538--538
/ptmr8t/very_important_count 
[2] [3] [4]
Underfull \hbox (badness 5637) in paragraph at lines 700--705
[]/ptmr8t/This works per-fectly for [][][]/ptmri8t/UP [][][] /ptmr8t/as well: t
he spin lock van-ishes, and this macro sim-ply be-comes
! Illegal unit of measure (replaced by filll).
<argument> <5:block^^I><5:block^^I>L
                                    ocking in the Linux Kernel</5:block></5:...
l.752      </fo:block></fo:block>
                                 </fo:block></fo:flow></fo:page-sequence><fo...

? 
! Emergency stop.
<argument> <5:block^^I><5:block^^I>L
                                    ocking in the Linux Kernel</5:block></5:...
l.752      </fo:block></fo:block>
                                 </fo:block></fo:flow></fo:page-sequence><fo...

!  ==> Fatal error occurred, the output PDF file is not finished!
Transcript written on tmp.log.
make[1]: *** [Documentation/DocBook/kernel-locking.pdf] Error 1
make: *** [pdfdocs] Error 2

--------------010601030209070403090401
Content-Type: text/plain;
 name="output-psdocs.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="output-psdocs.txt"

  XMLTO    Documentation/DocBook/wanbook.ps
Making portrait pages on USletter paper (8.5inx11in)
This is TeX, Version 3.14159 (Web2C 7.4.5)
(./tmp.fo
LaTeX2e <2001/06/01>
Babel <v3.7h> and hyphenation patterns for american, french, german, ngerman, n
ohyphenation, loaded.
xmltex version: 2002/06/25 v1.9 (Exp):
(/usr/share/texmf/tex/xmltex/xmltex.cfg) 
No File: tmp.cfg (/usr/share/texmf/tex/xmltex/passivetex/fotex.xmt)
(/usr/share/texmf/tex/latex/base/article.cls
Document Class: article 2001/04/21 v1.4e Standard LaTeX document class
(/usr/share/texmf/tex/latex/base/size10.clo))
(/usr/share/texmf/tex/xmltex/passivetex/fotex.sty
)
No file tmp.aux.
(/usr/share/texmf/tex/latex/cyrillic/t2acmr.fd)
(/usr/share/texmf/tex/latex/base/ts1cmr.fd)
(/usr/share/texmf/tex/latex/psnfss/t1ptm.fd)
No file tmp.out.
No file tmp.out.
INFO: Using normal, i.e. nonfrench-spacing in document
(/usr/share/texmf/tex/latex/psnfss/t1phv.fd)
(/usr/share/texmf/tex/latex/psnfss/t1pcr.fd) [1]
(/usr/share/texmf/tex/latex/psnfss/ts1ptm.fd) [2]
(/usr/share/texmf/tex/latex/amsfonts/umsa.fd)
(/usr/share/texmf/tex/latex/amsfonts/umsb.fd)
(/usr/share/texmf/tex/latex/wasysym/uwasy.fd)
(/usr/share/texmf/tex/latex/misc/ustmry.fd) [3]

LaTeX Font Warning: Font shape `OT1/cmr/m/n' in size <12.44159> not available
(Font)              size <12> substituted on input line 328.


LaTeX Font Warning: Font shape `OML/cmm/m/it' in size <12.44159> not available
(Font)              size <12> substituted on input line 328.


LaTeX Font Warning: Font shape `OMS/cmsy/m/n' in size <12.44159> not available
(Font)              size <12> substituted on input line 328.


LaTeX Font Warning: Font shape `OMX/cmex/m/n' in size <12.44159> not available
(Font)              size <12> substituted on input line 328.


LaTeX Font Warning: Font shape `U/msa/m/n' in size <12.44159> not available
(Font)              size <12> substituted on input line 328.


LaTeX Font Warning: Font shape `U/msb/m/n' in size <12.44159> not available
(Font)              size <12> substituted on input line 328.


LaTeX Font Warning: Font shape `U/wasy/m/n' in size <12.44159> not available
(Font)              size <12> substituted on input line 328.


LaTeX Font Warning: Font shape `U/stmry/m/n' in size <12.44159> not available
(Font)              size <12> substituted on input line 328.

[1]
Overfull \hbox (22.13274pt too wide) in paragraph at lines 384--384
[]\T1/phv/b/n/24.8832 Chapter$ $2.$ $Known Bugs And As-sump-tions 

! LaTeX Error: Something's wrong--perhaps a missing \item.

See the LaTeX manual or LaTeX Companion for explanation.
Type  H <return>  for immediate help.
 ...                                              
                                                  
l.386 ...o:inline></fo:block></fo:list-item-label>
                                                  <fo:list-item-body start-i...

? 
! Emergency stop.
 ...                                              
                                                  
l.386 ...o:inline></fo:block></fo:list-item-label>
                                                  <fo:list-item-body start-i...

Output written on tmp.dvi (4 pages, 14876 bytes).
Transcript written on tmp.log.
make[1]: *** [Documentation/DocBook/wanbook.ps] Error 1
make: *** [psdocs] Error 2

--------------010601030209070403090401--
