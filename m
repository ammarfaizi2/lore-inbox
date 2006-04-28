Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbWD1HwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbWD1HwD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 03:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030310AbWD1HwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 03:52:03 -0400
Received: from ns2.hostinglmi.net ([213.194.149.12]:33506 "EHLO
	ns2.hostinglmi.net") by vger.kernel.org with ESMTP id S1030308AbWD1HwA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 03:52:00 -0400
Date: Fri, 28 Apr 2006 09:57:25 +0200
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: David Vrabel <dvrabel@cantab.net>
Cc: Francois Romieu <romieu@fr.zoreil.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: IP1000 gigabit nic driver
Message-ID: <20060428075725.GA18957@fargo>
Mail-Followup-To: David Vrabel <dvrabel@cantab.net>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20060427142939.GA31473@fargo> <20060427185627.GA30871@electric-eye.fr.zoreil.com> <445144FF.4070703@cantab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <445144FF.4070703@cantab.net>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns2.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - pleyades.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Apr 27 at 11:26:07, David Vrabel wrote:
> I finally got around to putting a 2nd NIC in my box that has one of this 
> chips and was going to start fixing the driver up and preparing it for 
> submission this weekend.

Great!

>  Or I might try rewriting from scratch based on 
> the datasheet depending on how horrific the code looks on closer inspection.

For what i've seen, the code seems quite readable.

> Not got a whole lot of time to do this so no timescale for completion...

I could help. What things do you think need to be fixed before
submitting the driver?

cheers,

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
