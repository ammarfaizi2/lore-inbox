Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWBBPF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWBBPF2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWBBPF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:05:28 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17167 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751123AbWBBPEz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:04:55 -0500
Date: Wed, 1 Feb 2006 21:04:33 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CD writing - related question
Message-ID: <20060201210433.GC8552@ucw.cz>
References: <43DEA195.1080609@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DEA195.1080609@tmr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-01-06 18:30:29, Bill Davidsen wrote:
> Please take this as a question to elicit information, not 
> an invitation for argument.
> 
> In Linux currently:
>  SCSI - liiks like SCSI
>  USB - looks like SCSI
>  Firewaire - looks like SCSI
>  SATA - looks like SCSI
>  Compact flash and similar - looks like SCSI

Your definition of "looks like scsi" is way too broad. CF looks like
PCMCIA and that in turn is ide chip on isa-like bus.

(unless you plug it to usb reader)

-- 
Thanks, Sharp!
