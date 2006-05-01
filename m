Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWEATia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWEATia (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 15:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWEATia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 15:38:30 -0400
Received: from ns2.hostinglmi.net ([213.194.149.12]:9665 "EHLO
	ns2.hostinglmi.net") by vger.kernel.org with ESMTP id S932194AbWEATi3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 15:38:29 -0400
Date: Mon, 1 May 2006 21:39:32 +0200
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: David Vrabel <dvrabel@cantab.net>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: IP1000 gigabit nic driver
Message-ID: <20060501193932.GA25075@fargo>
Mail-Followup-To: Pekka Enberg <penberg@cs.helsinki.fi>,
	David Vrabel <dvrabel@cantab.net>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20060427142939.GA31473@fargo> <20060427185627.GA30871@electric-eye.fr.zoreil.com> <445144FF.4070703@cantab.net> <20060428075725.GA18957@fargo> <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com> <20060428113755.GA7419@fargo> <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI> <1146306567.1642.3.camel@localhost> <20060429122119.GA22160@fargo> <1146342905.11271.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1146342905.11271.3.camel@localhost>
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

Hi Pekka,

On Apr 29 at 11:35:04, Pekka Enberg wrote:
> No, I haven't. I don't have the hardware, so I can't test the driver.
> Furthermore, there's plenty of stuff to fix before it's in any shape for
> submission. If someone wants to give this patch a spin, I would love to
> hear the results.

The latest version of the driver including David's improvements works
here. Nice work ;)

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
