Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267933AbTBMALb>; Wed, 12 Feb 2003 19:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267939AbTBMALb>; Wed, 12 Feb 2003 19:11:31 -0500
Received: from palrel11.hp.com ([156.153.255.246]:5847 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id <S267933AbTBMALa>;
	Wed, 12 Feb 2003 19:11:30 -0500
Date: Wed, 12 Feb 2003 16:21:19 -0800
To: Tim Pepper <tpepper@bougret.hpl.hp.com>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: Cisco Aironet 340 oops with 2.4.20
Message-ID: <20030213002119.GA31923@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030210125342.4462c25b.gigerstyle@gmx.ch> <20030212161850.A2088@jose.vato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212161850.A2088@jose.vato.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 04:18:50PM -0800, Tim Pepper wrote:
> I've had oopses in 2.4.19 if I leave Cisco's acu utility running while
> I have much net activity.  Haven't looked to see if it still happens
> in 2.4.20 or expended the effort to get better debug info.  I'm using
> a cisco 352lmc card fwiw.
> 
> Tim

	Why don't you report it to the driver maintainers ?
	Please note that ACU is closed source, so it will be probably
more difficult to debug.
	Regards,

	Jean
