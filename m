Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319297AbSIFSfw>; Fri, 6 Sep 2002 14:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319312AbSIFSfw>; Fri, 6 Sep 2002 14:35:52 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:4810 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S319297AbSIFSfv> convert rfc822-to-8bit; Fri, 6 Sep 2002 14:35:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre5-ac4
Date: Fri, 6 Sep 2002 20:40:16 +0200
User-Agent: KMail/1.4.2
References: <200209061500.g86F08m12929@devserv.devel.redhat.com>
In-Reply-To: <200209061500.g86F08m12929@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209062040.17002.hpj@urpla.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

in case, you didn't noticed already...

--- linux.20pre5/Makefile   2002-08-29 18:39:52.000000000 +0100
+++ linux.20pre5-ac4/Makefile   2002-09-05 15:10:59.000000000 +0100
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 20
-EXTRAVERSION = -pre5
+EXTRAVERSION = -pre5-ac3

I'm trying it now with my diskless setup (this way, I'm pretty
immune against ide probs :-). Using ide hd for v4l2 recording, 
though. -pre5-ac1 had a ide-scsi (dvd) problem on VIA vt82c686a.

Cheers,
Hans-Peter
