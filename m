Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSHGAF2>; Tue, 6 Aug 2002 20:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSHGAF2>; Tue, 6 Aug 2002 20:05:28 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:42697 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316573AbSHGAF2>;
	Tue, 6 Aug 2002 20:05:28 -0400
Date: Tue, 6 Aug 2002 17:09:05 -0700
To: Tomas Szepe <szepe@pinerecords.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] New Wireless Extension API - part2
Message-ID: <20020807000905.GA12748@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20020806180931.GE11313@bougret.hpl.hp.com> <20020807000118.GA2830@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020807000118.GA2830@louise.pinerecords.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 02:01:18AM +0200, Tomas Szepe wrote:
> > 	Here is the second part of the new driver API for Wireless
> > Extensions. Few facts :
> > 		o needed by the new airo driver in 2.4.20-pre1
> 
> Does this mean the Aironet driver in 2.4.20-pre1 doesn't work currently?
> 
> T.

	No, I would have put "required". And Javier would never had
done something that stupid.
	The Aironet driver in 2.4.20-pre1 has some new features that
depend on WE-14 (such as wireless scanning and wireless events), but
they are not *critical* features. On the other hand, I would invite
you to try those new features...
	Have fun...

	Jean
