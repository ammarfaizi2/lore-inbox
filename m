Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290461AbSBKVBL>; Mon, 11 Feb 2002 16:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290454AbSBKVBC>; Mon, 11 Feb 2002 16:01:02 -0500
Received: from [209.205.26.42] ([209.205.26.42]:32774 "HELO
	gateway.fpelectronics.com") by vger.kernel.org with SMTP
	id <S290423AbSBKVAs> convert rfc822-to-8bit; Mon, 11 Feb 2002 16:00:48 -0500
Message-ID: <200202111559320446.2581AD39@notes.fpelectronics.com>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Mon, 11 Feb 2002 15:59:32 -0500
From: "Al Moote" <amoote@ivhs.com>
To: linux-kernel@vger.kernel.org
Subject: "All of your loopback devices are in use!" reported by
  mkinitrd
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on notes/MarkIV(Release 5.0.9 |November 16, 2001) at
 02/11/2002 03:55:58 PM,
	Serialize by Router on notes/MarkIV(Release 5.0.9 |November 16, 2001) at 02/11/2002
 03:55:58 PM,
	Serialize complete at 02/11/2002 03:55:58 PM
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all.  I am not-so new to Linux, but I haven't had to recompile my kernel before.  We are taking the leap into Samba Fileserving an thus, I need to add ACL functionality to my kernel.  I have opted to go with 2.4.17 and have had some success so far.  I am, however, stuck at one point.

I am trying to make my .img file to support my RAID devices.  When I run:

/sbin/mkinitrd /boot/initrd-2.4.17-021102.img 2.4.17-021102

I get the message:

All of your loopback devices are in use!

I don't really understand why this is preventing me from creatingthe .img file.  But then again, I have little experience in this area.  I was hoping somebody on this list could len a hand.  Thanks alot guys (and the occasional gal).

Al Moote

