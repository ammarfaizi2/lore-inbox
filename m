Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131949AbQK0DuH>; Sun, 26 Nov 2000 22:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132267AbQK0Dt6>; Sun, 26 Nov 2000 22:49:58 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:6417 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S131949AbQK0Dtn>; Sun, 26 Nov 2000 22:49:43 -0500
Date: Sun, 26 Nov 2000 21:16:42 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: syslinux and 2.4.0 initrd size problems
Message-ID: <20001126211642.A2763@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I am having trouble getting a 2.4 vmlinuz (bzImage) and initrd 
image onto a 1.44 floppy with all the new stuff.  Even a stipped 
down kernel compiled under 2.4 is @ 600K compressed, and I need 
about 800K for the initrd image.  I noticed that syslinux 
has some comments about not allowing initrd to span media.  

I there something more current that does or will allow me to
load the inittrd off a CD-ROM device (with vmlinuz and syslinux
on the floppy).   I know how to do this with GRUB (Grand 
Unified Boot Loader), but I want to use syslinux if possible. 

Thanks

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
