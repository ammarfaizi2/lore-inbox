Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129523AbQK0We3>; Mon, 27 Nov 2000 17:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129805AbQK0WeK>; Mon, 27 Nov 2000 17:34:10 -0500
Received: from [216.161.55.93] ([216.161.55.93]:16118 "EHLO blue.int.wirex.com")
        by vger.kernel.org with ESMTP id <S129523AbQK0WeA>;
        Mon, 27 Nov 2000 17:34:00 -0500
Date: Mon, 27 Nov 2000 14:03:53 -0800
From: Greg KH <greg@wirex.com>
To: Kurt Garloff <kurt@garloff.de>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: USB-Storage drivers
Message-ID: <20001127140353.B1328@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, Kurt Garloff <kurt@garloff.de>,
        Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001127221623.D24187@garloff.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001127221623.D24187@garloff.etpnet.phys.tue.nl>; from kurt@garloff.de on Mon, Nov 27, 2000 at 10:16:23PM +0100
X-Operating-System: Linux 2.2.17-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 10:16:23PM +0100, Kurt Garloff wrote:
> Hi Matthew, David, Linus,
> 
> any particular reason why the support for special dongles in the usb-storage
> driver can not be selected during kernel configuration? (See attached patch).

A patch is pending that I submitted that adds the
CONFIG_USB_STORAGE_FREECOM option and cleans up the whole USB
configuration section.  See the archive of the linux-usb-devel list for
a copy of it (or just ask, I have it around here somewhere...)

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
