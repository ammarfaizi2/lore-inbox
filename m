Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314361AbSEIVEL>; Thu, 9 May 2002 17:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314362AbSEIVEK>; Thu, 9 May 2002 17:04:10 -0400
Received: from mailhost2.teleline.es ([195.235.113.141]:42013 "EHLO
	tsmtp9.mail.isp") by vger.kernel.org with ESMTP id <S314361AbSEIVEJ>;
	Thu, 9 May 2002 17:04:09 -0400
Date: Thu, 9 May 2002 23:07:17 +0200
From: Diego Calleja <DiegoCG@teleline.es>
To: christian.burger@edb.ericsson.se
Cc: linux-kernel@vger.kernel.org
Subject: Re: fonts corruption with 3dfx drm module
Message-Id: <20020509230717.38c4eb9e.DiegoCG@teleline.es>
In-Reply-To: <3CDA61CA.498991DF@edb.ericsson.se>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 May 2002 14:47:22 +0300
Christian Burger <christian.burger@edb.ericsson.se> escribió:

> I've seen a much more serious problem which seems to be related to this:
> I have AMD Athlon K7 650MHz, Via chipset, Voodoo5 5500AGP, MTTR enabled.
> What is happening here is that when switching back from init 5 to init 3 for
> instance, the system hangs completely and a blinking character appears in a
> black screen. There's no other way other than to power cycle the system. It
> seems to be a kernel panic.
I've seen a blinking character (green, if i can remember) with my voodoo 3 3000 PCI, but
I could change the VT.

The only issue with my graphics card is the corruption of some characters, when switching 
X to/from vt. The most affected character is: ! .


Diego Calleja <DiegoCG@teleline.es>
