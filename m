Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267942AbTBMAo6>; Wed, 12 Feb 2003 19:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267944AbTBMAo5>; Wed, 12 Feb 2003 19:44:57 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:54449 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267942AbTBMAo5>; Wed, 12 Feb 2003 19:44:57 -0500
Date: Thu, 13 Feb 2003 01:54:43 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Tim Pepper <tpepper@louise.pinerecords.com>,
       Marc Giger <gigerstyle@gmx.ch>, linux-kernel@vger.kernel.org,
       jt@hpl.hp.com
Subject: Re: Cisco Aironet 340 oops with 2.4.20
Message-ID: <20030213005443.GA11154@louise.pinerecords.com>
References: <20030210125342.4462c25b.gigerstyle@gmx.ch> <20030212161850.A2088@jose.vato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212161850.A2088@jose.vato.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [tpepper@vato.org]
> 
> I've had oopses in 2.4.19 if I leave Cisco's acu utility running while
> I have much net activity.  Haven't looked to see if it still happens
> in 2.4.20 or expended the effort to get better debug info.  I'm using
> a cisco 352lmc card fwiw.

Also the driver deterministically oopses upon the rmmod of airo.o.
It's been like that since 2.4.18 or so.

-- 
Tomas Szepe <szepe@pinerecords.com>
