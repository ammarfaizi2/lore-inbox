Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbUAaRbl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 12:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbUAaRbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 12:31:41 -0500
Received: from post.tau.ac.il ([132.66.16.11]:64743 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S264974AbUAaRbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 12:31:39 -0500
Date: Sat, 31 Jan 2004 19:29:30 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: linux-kernel@vger.kernel.org
Subject: Re: possible hint for "irq 11: nobody cared!" (asus p4p800)
Message-ID: <20040131172930.GD11658@luna.mooo.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <401A4921.6090908@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401A4921.6090908@tiscali.it>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.3; VDF: 6.23.0.53; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 01:08:01PM +0100, Carlo Salinari wrote:
> Hello,
> 
> I've had a hard time at work trying to install 2.6.1 on a ASUS P4P800 
> motherboard
> (whith RAID controller _disabled_ in the bios).
> 
> I constantly got "irq 11: nobody cared!" message, which I now see is a 
> known problem
> here.
> 
> After many (many!) tries whith different compilation/boot-time options, 
> whith
> both 2.6.1 and 2.4.24, I just realized that Debian Woody's (3.0r1) bf24 
> kernel
> (2.4.18) boots flawlessly.
> 

On my system, 2.4 doesn't have problems, I got this message with 2.6
and irq 7 iirc. The message claimed it was related to 8139too.

> I thought that possibly this might be a hint for the experts on the list.
> 
> cheers,
>    Carlo Salinari
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
