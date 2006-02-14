Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030555AbWBNKaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030555AbWBNKaO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030556AbWBNKaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:30:13 -0500
Received: from host-84-9-201-245.bulldogdsl.com ([84.9.201.245]:13699 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1030555AbWBNKaM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:30:12 -0500
Date: Tue, 14 Feb 2006 10:30:03 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: Alessandro Zummo <azummo-vger@towertech.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] RTC subsystem
Message-ID: <20060214103003.GA14880@home.fluff.org>
References: <20060213225416.865078000@towertech.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213225416.865078000@towertech.it>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 11:54:16PM +0100, Alessandro Zummo wrote:
> 
>  Hello,
> 
>   this release of the new RTC subsystem has got
>  a few locking issues fixed as well as new
>  drivers for the Ricoh RS5C372A/B and
>  Philips PCF8563/Epson RTC8564.
> 
>   Detection routines have been improved
>  in some drivers, while some others now require
>  a specific probe parameter in order to
>  avoid spurious writes on I2C eeprom chips.
> 
>  As usual, your feedback is highly appreciated.

are you planning on doing the updates for the
s3c2410-rtc.c driver?

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
