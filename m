Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVGPUFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVGPUFN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 16:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVGPUFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 16:05:12 -0400
Received: from [82.94.235.170] ([82.94.235.170]:33720 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S261452AbVGPUFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 16:05:10 -0400
From: Norbert van Nobelen <norbert@edusupport.nl>
Organization: EduSupport BV
To: linux-kernel@vger.kernel.org
Subject: Re: Sandisk Compact Flash
Date: Sat, 16 Jul 2005 22:03:54 +0000
User-Agent: KMail/1.6.2
References: <OFF2465F02.D3F1F2D8-ON6525703D.0049BB41-6525703D.004A8B94@in.abb.com> <42D8B196.8030208@m1k.net> <20050716183100.GA4266@sonic.net>
In-Reply-To: <20050716183100.GA4266@sonic.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200507162203.54858.norbert@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So then you will have to reboot sometimes. BTW, IDE can be hot swapped if you 
are carefull:
Umount the device,
unplug it.
Plug in the same device (same model)
Remount.
A bit risky to your hardware, but I have used this way for harddisks several 
time when a system has to keep running. Never used it for compact flash 
though.

Another option: Buy an USB card controller or a pcmcia controller for in your 
pc. Costs about $10,-

Op zaterdag 16 juli 2005 18:31, schreef u:
> On Sat, Jul 16, 2005 at 03:04:54AM -0400, Michael Krufky wrote:
> > I recommend picking up a CF-to-IDE adapter, such as this:
> >
> > http://www.acscontrol.com/Index_ACS.asp?Page=/Pages/Products/CompactFlash
> >/IDE_To_CF_Adapter.htm
>
> That's fine if you have a spare IDE port, but unlikely if you're
> using a laptop.  Also these do not support hot swapping.
>
> -- Dave
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
