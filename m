Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130897AbQK0Qvt>; Mon, 27 Nov 2000 11:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130312AbQK0Qvi>; Mon, 27 Nov 2000 11:51:38 -0500
Received: from [204.244.205.25] ([204.244.205.25]:64028 "HELO post.gateone.com")
        by vger.kernel.org with SMTP id <S130897AbQK0Qve>;
        Mon, 27 Nov 2000 11:51:34 -0500
From: Michael Peddemors <michael@linuxmagic.com>
Organization: Wizard Internet Services
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: syslinux and 2.4.0 initrd size problems
Date: Mon, 27 Nov 2000 09:29:08 -0800
X-Mailer: KMail [version 1.1.95.0]
Content-Type: text/plain
In-Reply-To: <20001126211642.A2763@vger.timpanogas.org>
In-Reply-To: <20001126211642.A2763@vger.timpanogas.org>
MIME-Version: 1.0
Message-Id: <0011270929080J.00154@mistress>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Happily using initrd on a 1.44 floppy here, and there should be no reason why 
you can't use it for a CDROM distro as well, you can have syslinux on the 
CDROM too... I believe their is a a syslinux mailing list to check if you 
have problems, and he has recently released updated versions of syslinux.

On Sun, 26 Nov 2000, Jeff V. Merkey wrote:
> I am having trouble getting a 2.4 vmlinuz (bzImage) and initrd
> image onto a 1.44 floppy with all the new stuff.  Even a stipped
> down kernel compiled under 2.4 is @ 600K compressed, and I need
> about 800K for the initrd image.  I noticed that syslinux
> has some comments about not allowing initrd to span media.
>
> I there something more current that does or will allow me to
> load the inittrd off a CD-ROM device (with vmlinuz and syslinux
> on the floppy).   I know how to do this with GRUB (Grand
> Unified Boot Loader), but I want to use syslinux if possible.

--------------------------------------------------------
Michael Peddemors - Senior Consultant
Unix Administration - WebSite Hosting
Network Services - Programming
Wizard Internet Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604) 589-0037 Beautiful British Columbia, Canada
--------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
