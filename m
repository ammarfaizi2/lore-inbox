Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266750AbSKURpr>; Thu, 21 Nov 2002 12:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbSKURpr>; Thu, 21 Nov 2002 12:45:47 -0500
Received: from m3.azalea.se ([217.75.96.207]:49556 "HELO m3.azalea.se")
	by vger.kernel.org with SMTP id <S266750AbSKURph>;
	Thu, 21 Nov 2002 12:45:37 -0500
Subject: make pdfdocs fails in 2.5.48 at parportbook.pdf
From: Mikael Olenfalk <mikael@netgineers.se>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 21 Nov 2002 16:55:07 +0100
Message-Id: <1037894107.765.13.camel@devcon-x>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Gurus,


I just wanted to read some beautiful PDF-docs about the newest kernel,
but it failed at some point, hopefully you can help me :)

Sorry, but I'm very knew to Tex and the things around it, so I wasn't
able to cut the info down very much, because I don't know what's
important and what's not :( I did cut it down little though :)



Working on: /usr/src/linux-2.5.48/Documentation/DocBook/parportbook.sgml
40.


LaTeX Warning: Reference `641' on page iii undefined on input line 870.


-- snip -- a millions of the same warning removed -- snip --


LaTeX Warning: Reference `1785' on page iii undefined on input line
1596.


Package Fancyhdr Warning: fancyhdr's E option without twoside option is
useless
 on input line 1603.

[3.0.22]

LaTeX Warning: Reference `1832' on page iv undefined on input line 1623.


LaTeX Warning: Reference `1870' on page iv undefined on input line 1657.


LaTeX Warning: Reference `FDL' on page iv undefined on input line 1691.

[4.0.22]

Package Fancyhdr Warning: fancyhdr's E option without twoside option is
useless
 on input line 1782.

-- snip -- last message repeated 2 times -- snip --

! pdfTeX warning (ext4): destination with the same identifier
(name{page.1}) ha
s been already used, duplicate ignored
<to be read again> 
                   \penalty 
l.2077    \endPar{}
                   \endNode{}\endSeq{}\endDisplayGroup{}\endNode{}\Node%
[1.0.22]

! LaTeX Error: File `parport-share' not found.

See the LaTeX manual or LaTeX Companion for explanation.
Type  H <return>  for immediate help.
 ...                                              
                                                  
l.2252 {EPS}}
             \endNode{}\endNode{}\endSeq{}\endPar{}\endNode{}\Node%
! pdfTeX warning (ext4): destination with the same identifier
(name{page.2}) ha
s been already used, duplicate ignored
<to be read again> 
                   \penalty 
l.2297 ...DisplayGroup{}\endNode{}\endSeq{}\endSpS
                                                  {}\endNode{}\Node%
[2.0.22]

Package Fancyhdr Warning: fancyhdr's E option without twoside option is
useless
 on input line 2384.

-- snip -- last message repeated 2 times -- snip --

! pdfTeX warning (ext4): destination with the same identifier
(name{page.3}) ha
s been already used, duplicate ignored
<to be read again> 
                   \penalty 
l.2535   \endPar{}\endNode{}\endSeq{}\endSpS
                                            {}\endNode{}\Node% [3.0.22]

-- snip -- "fancyhdr's E" message repeated 2 times -- snip --

! LaTeX Error: File `parport-structure' not found.

See the LaTeX manual or LaTeX Companion for explanation.
Type  H <return>  for immediate help.
 ...                                              
                                                  
l.2683 {EPS}}
             \endNode{}\endNode{}\endSeq{}\endPar{}\endNode{}\Node%

Package Fancyhdr Warning: fancyhdr's E option without twoside option is
useless
 on input line 3054.

! pdfTeX warning (ext4): destination with the same identifier
(name{page.4}) ha
s been already used, duplicate ignored
<to be read again> 
                   \penalty 
l.3054    \endPar{}
                   \endNode{}\Node% [4.0.22] [5.0.22]

! LaTeX Error: File `parport-multi' not found.

See the LaTeX manual or LaTeX Companion for explanation.
Type  H <return>  for immediate help.
 ...                                              
                                                  
l.3392 {EPS}}
             \endNode{}\endNode{}\endSeq{}\endPar{}\endNode{}\Node%
(/usr/share/texmf/tex/latex/amsfonts/umsa.fd)
(/usr/share/texmf/tex/latex/amsfonts/umsb.fd)
(/usr/share/texmf/tex/latex/wasysym/uwasy.fd)
(/usr/share/texmf/tex/latex/misc/ustmry.fd) [6.0.22]

Package Fancyhdr Warning: fancyhdr's E option without twoside option is
useless
 on input line 3843.

-- snip -- last message repeated 2 times -- snip --

[7.0.22] [8.0.22] [9.0.22] [10.0.22] [11.0.22]

Package Fancyhdr Warning: fancyhdr's E option without twoside option is
useless
 on input line 5647.

-- snip -- last message repeated 2 times -- snip --

[12.0.22]

Package Fancyhdr Warning: fancyhdr's E option without twoside option is
useless
 on input line 6059.

-- snip -- last message repeated 2 times -- snip --

[13.0.22] [14.0.22] [15.0.22] [16.0.22]

Package Fancyhdr Warning: fancyhdr's E option without twoside option is
useless
 on input line 7363.

-- snip -- last message repeated 2 times -- snip --

[17.0.22] [18.0.22] [19.0.22] [20.0.22] [21.0.22] [22.0.22] [23.0.22]
[24.0.22]
 [25.0.22] [26.0.22] [27.0.22]

Package Fancyhdr Warning: fancyhdr's E option without twoside option is
useless
 on input line 11029.

-- snip -- last message repeated 2 times -- snip --

[28.0.22] [29.0.22] [30.0.22] [31.0.22] [32.0.22] [33.0.22] [34.0.22
! pdfTeX warning (ext4): destination with the same identifier
(name{1237}) has 
been already used, duplicate ignored
<to be read again> 
                   \endgroup 
l.14519 {1}}
            \Seq%] [35.0.22] [36.0.22
! pdfTeX warning (ext4): destination with the same identifier
(name{1322}) has 
been already used, duplicate ignored
<to be read again> 
                   \endgroup 
l.15613 {1}}
            \Node%] [37.0.22] [38.0.22] [39.0.22] [40.0.22] [41.0.22]
[42.0.22]
[43.0.22] [44.0.22] [45.0.22] [46.0.22] [47.0.22]

Package Fancyhdr Warning: fancyhdr's E option without twoside option is
useless
 on input line 20752.

-- snip -- last message repeated 2 times -- snip --

[48.0.22]

Package Fancyhdr Warning: fancyhdr's E option without twoside option is
useless
 on input line 21237.

-- snip -- last message repeated 2 times -- snip --

[49.0.22] [50.0.22] [51.0.22] [52.0.22] [53.0.22] [54.0.22] [55.0.22]
(./parportbook.aux)

LaTeX Warning: There were undefined references.

 )
(see the transcript file for additional
information){/usr/share/texmf/dvips/bas
e/8r.enc}</usr/share/texmf/fonts/type1/bluesky/cm/cmmi9.pfb>
Output written on parportbook.pdf (59 pages, 290232 bytes).
Transcript written on parportbook.log.
make[1]: *** [Documentation/DocBook/parportbook.pdf] Error 9
make: *** [pdfdocs] Error 2
devcon-x:/usr/src/linux-2.5.48# 



With friendly regards,



Mikael Olenfalk


-- 

Mikael Olenfalk
Netgineers, Sweden
<mikael at netgineers dot se>

