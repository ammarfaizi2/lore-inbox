Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWCURpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWCURpq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWCURpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:45:46 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:40379 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751471AbWCURpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:45:45 -0500
Date: Tue, 21 Mar 2006 18:45:35 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "J. Bruce Fields" <bfields@fieldses.org>,
       Matheus Izvekov <mizvekov@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SubmittingPatches typo
In-Reply-To: <1142939779.21455.43.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0603211836220.21376@yvahk01.tjqt.qr>
References: <20060320125012.GA21545@elf.ucw.cz>  <Pine.LNX.4.61.0603202056100.14231@yvahk01.tjqt.qr>
  <305c16960603201247p53718859ofa0e6d0355c9da1a@mail.gmail.com> 
 <20060320210209.GD31512@fieldses.org> <1142939779.21455.43.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Jan: Care to submit an updated patch as the original is indeed wrong ?
>
Here you go. On that occassion, I fixed one more of the Torvalds-related 
Genetives.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

diff --fast -Ndpru linux-2.6.16~/Documentation/DocBook/kernel-locking.tmpl linux-2.6.16-typofix/Documentation/DocBook/kernel-locking.tmpl
--- linux-2.6.16~/Documentation/DocBook/kernel-locking.tmpl	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-typofix/Documentation/DocBook/kernel-locking.tmpl	2006-03-21 18:38:37.227544000 +0100
@@ -1916,7 +1916,7 @@ machines due to caching.
     <listitem>
      <para>
        <filename>Documentation/spinlocks.txt</filename>: 
-       Linus Torvalds' spinlocking tutorial in the kernel sources.
+       Linus Torvalds's spinlocking tutorial in the kernel sources.
      </para>
     </listitem>
 
diff --fast -Ndpru linux-2.6.16~/Documentation/SubmittingPatches linux-2.6.16-typofix/Documentation/SubmittingPatches
--- linux-2.6.16~/Documentation/SubmittingPatches	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-typofix/Documentation/SubmittingPatches	2006-03-21 18:39:04.627544000 +0100
@@ -490,7 +490,7 @@ NO!!!! No more huge patch bombs to linux
 Kernel Documentation/CodingStyle
   <http://sosdg.org/~coywolf/lxr/source/Documentation/CodingStyle>
 
-Linus Torvald's mail on the canonical patch format:
+Linus Torvalds's mail on the canonical patch format:
   <http://lkml.org/lkml/2005/4/7/183>
 --
 Last updated on 17 Nov 2005.
#<eof>


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
