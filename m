Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263288AbRFTVbu>; Wed, 20 Jun 2001 17:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263433AbRFTVbk>; Wed, 20 Jun 2001 17:31:40 -0400
Received: from mail01.onetelnet.fr ([213.78.0.138]:4163 "EHLO
	mail01.onetelnet.fr") by vger.kernel.org with ESMTP
	id <S263288AbRFTVba>; Wed, 20 Jun 2001 17:31:30 -0400
Message-ID: <3B311519.3090401@free.fr>
Date: Wed, 20 Jun 2001 23:26:49 +0200
From: FORT David <popo.enlighted@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: fr, en-us
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: is there a linux running on jvm arch ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I 've tested the User Mode Linux a few times ago, and it gave me an 
idea: given the fact that we had a GCC which
produce bytecode from C, it would be possible to produce a port of 
linux(a new directory "jvm" in the arch dir) which
would run in a Java Virtual Machine. (after some inquiries such compiler 
does not exist :-( )
I'm dreaming of a linux booting in a browser applet(imagine sending such 
thing in a mail to MS peoples !!!!)

