Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268153AbTBYRhG>; Tue, 25 Feb 2003 12:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268156AbTBYRhG>; Tue, 25 Feb 2003 12:37:06 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:38673 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268153AbTBYRhE>;
	Tue, 25 Feb 2003 12:37:04 -0500
Date: Tue, 25 Feb 2003 09:39:15 -0800
From: Greg KH <greg@kroah.com>
To: engidudu <usbhc_dev@nergal.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SL811HS driver
Message-ID: <20030225173914.GD8648@kroah.com>
References: <004501c2dcf0$8e2757c0$570610ac@pclab1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004501c2dcf0$8e2757c0$570610ac@pclab1>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 06:08:45PM +0100, engidudu wrote:
> Hi,
> 
> we have modified the linux driver for SL811 USB HOST Controller by CYPRESS.
> We have improved the program's flow:
> - interrupt handler,
> - double buffering.
> It works well during writing transactions, but we still have problems
> implementing
> double buffering during reading transactions.
> We would like to send you our source code to attend the next kernel release.
> These codes work on uClinux (kernel 2.4) too.
> 
> How do we have to send these codes?

Please read Documentation/SubmittingPatches and then send the patch to
me and the linux-usb-devel mailing list.  You can also copy linux-kernel
if you really want to.

thanks,

greg k-h
