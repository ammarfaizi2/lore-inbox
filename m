Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUIFItp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUIFItp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 04:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267624AbUIFItp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 04:49:45 -0400
Received: from ip189.73.1311O-CUD12K-02.ish.de ([62.143.73.189]:19072 "EHLO
	sheridan") by vger.kernel.org with ESMTP id S263778AbUIFItk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 04:49:40 -0400
From: Marcus Metzler <mocm@mocm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16700.9401.569488.38007@mocm.de>
Date: Mon, 6 Sep 2004 10:50:01 +0200
To: Emmanuel Fleury <fleury@cs.aau.dk>
Cc: Linux Kernel Mailing-list <linux-kernel@vger.kernel.org>,
       Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [Transmeta hardware] Update of the CMS under Linux ?
In-Reply-To: <1094457952.22441.34.camel@rade7.e.cs.auc.dk>
References: <1093165082.11189.20.camel@aphrodite.olympus.net>
	<ch8lop$m3t$1@sea.gmane.org>
	<1094457952.22441.34.camel@rade7.e.cs.auc.dk>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: mocm@mocm.de
X-Face: X!$Vwl\?,AW_[zm^ej\MLxN>q;R?C_sRZ*XE4V;BGT28Ewyd\:TS')W'G#Dgay8ci$*{lEd
 02(Nk0OndG\752U>lozmb_R1poDm6mgHm_4.}bdS0hh.`xGUI.X2x_50T9.?_v~.,QI*$2:Q=HV@>F
 IP6%l~E:T|w,X[eC;|YD(A9X'sS"r$l]g<4CjAm4|f7o0>6zGwUPLinP0.d=E+_%?4>0A9'esEZ=9h
 $#b[g*/q/g'GVj-hDc,+V_]1.H^N,1Bju,>5FZn"B
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Emmanuel" == Emmanuel Fleury <fleury@cs.aau.dk> writes:

    Emmanuel> Hi, Actually, I have an answer to my question by now.

    Emmanuel> The way the CMS is built-in on the hardware allow one
    Emmanuel> way to upgrade the firmware (and only one, as far as I
    Emmanuel> understood in
    Emmanuel> http://www.realworldtech.com/page.cfm?ArticleID=RWT010204000000
    Emmanuel> and
    Emmanuel> http://www.realworldtech.com/page.cfm?ArticleID=RWT012704012616).


    Emmanuel> I am gathering some informations on a bug in the CMS
    Emmanuel> here: http://www.cs.auc.dk/~fleury/bug_cms/index.html

I read the description of your bug and discovered that my problems
with my Fujitsu Biblo Loox T93C notebook (AFAIK the Japanese version
of the Lifebook 2120) seem to have the same cause. Since you seem to
be collecting a list of hardware that has this bug, here is my
information:
I am using debian testing with kernel 2.6.4 (from kernel.org) and
XFree86 Version 4.3.0.1. dmesg gives the following information about
the CMS version: 

CPU:     After generic identify, caps: 0084893f 0081813f 00000000 00000000
CPU:     After vendor identify, caps: 0084893f 0081813f 000000ce 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.4.1.0, 933 MHz
CPU: Code Morphing Software revision 4.3.3-9-562
CPU: 20030107 01:17 official release 28.0.1-4.3.3#1
CPU serial number disabled.
CPU:     After all inits, caps: 0080893f 0081813f 000000ce 00000000
CPU: Transmeta(tm) Crusoe(tm) Processor TM5800 stepping 03


Marcus

-- 
/--------------------------------------------------------------------\
| Dr. Marcus O.C. Metzler        |                                   |
| mocm@metzlerbros.de            | http://www.metzlerbros.de/        |
\--------------------------------------------------------------------/
 |>>>             Quis custodiet ipsos custodies                 <<<|
