Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261473AbRFTVhu>; Wed, 20 Jun 2001 17:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbRFTVhk>; Wed, 20 Jun 2001 17:37:40 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:26914 "EHLO
	mailsorter1.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S261473AbRFTVh0>; Wed, 20 Jun 2001 17:37:26 -0400
Message-ID: <3AB544CBBBE7BF428DA7DBEA1B85C79C9B6BD7@nocmail.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'FORT David'" <popo.enlighted@free.fr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: is there a linux running on jvm arch ?
Date: Wed, 20 Jun 2001 17:37:17 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I 've tested the User Mode Linux a few times ago, and it gave me an 
>idea: given the fact that we had a GCC which
>produce bytecode from C, it would be possible to produce a port of 
>linux(a new directory "jvm" in the arch dir) which
>would run in a Java Virtual Machine. (after some inquiries such compiler 
>does not exist :-( )
>I'm dreaming of a linux booting in a browser applet(imagine sending such 
>thing in a mail to MS peoples !!!!)

While I am not sure if this is possible with Linux, something like this has
already been done with Inferno.  Check out:
http://www.vitanuova.com/inferno/pidoc/index.html

B.
