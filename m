Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131714AbQK0Rkw>; Mon, 27 Nov 2000 12:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132331AbQK0Rkn>; Mon, 27 Nov 2000 12:40:43 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:55569 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S131988AbQK0Rkf>; Mon, 27 Nov 2000 12:40:35 -0500
Date: Mon, 27 Nov 2000 11:07:05 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Michael Peddemors <michael@linuxmagic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: syslinux and 2.4.0 initrd size problems
Message-ID: <20001127110705.E4652@vger.timpanogas.org>
In-Reply-To: <20001126211642.A2763@vger.timpanogas.org> <0011270929080J.00154@mistress>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <0011270929080J.00154@mistress>; from michael@linuxmagic.com on Mon, Nov 27, 2000 at 09:29:08AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 09:29:08AM -0800, Michael Peddemors wrote:
> Happily using initrd on a 1.44 floppy here, and there should be no reason why 
> you can't use it for a CDROM distro as well, you can have syslinux on the 
> CDROM too... I believe their is a a syslinux mailing list to check if you 
> have problems, and he has recently released updated versions of syslinux.

I've got it working here too, but not with an initrd image and vmlinuz image
that's bigger than the floppy.  

Jeff

> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
