Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265777AbSLIQvJ>; Mon, 9 Dec 2002 11:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265791AbSLIQvJ>; Mon, 9 Dec 2002 11:51:09 -0500
Received: from havoc.daloft.com ([64.213.145.173]:40149 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S265777AbSLIQvJ>;
	Mon, 9 Dec 2002 11:51:09 -0500
Date: Mon, 9 Dec 2002 11:58:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: ksardem@linux01.gwdg.de
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: bug in via-rhine network-driver (transmit timed out)
Message-ID: <20021209165847.GA17495@gtf.org>
References: <1653237694.20021209175407@linux01.gwdg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653237694.20021209175407@linux01.gwdg.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 05:54:07PM +0100, ksardem@linux01.gwdg.de wrote:
> Hi,
> 
> I successfully got the old transmit-out-error again ;-)
> - and this time with "options via-rhine debug=3" in modules.conf.

Does booting with "noapic" in lilo/grub fix this?

