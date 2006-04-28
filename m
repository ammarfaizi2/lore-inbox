Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbWD1Lcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbWD1Lcb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 07:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbWD1Lca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 07:32:30 -0400
Received: from ns2.hostinglmi.net ([213.194.149.12]:9622 "EHLO
	ns2.hostinglmi.net") by vger.kernel.org with ESMTP id S965004AbWD1Lc3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 07:32:29 -0400
Date: Fri, 28 Apr 2006 13:37:55 +0200
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: David Vrabel <dvrabel@cantab.net>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: IP1000 gigabit nic driver
Message-ID: <20060428113755.GA7419@fargo>
Mail-Followup-To: Pekka Enberg <penberg@cs.helsinki.fi>,
	David Vrabel <dvrabel@cantab.net>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20060427142939.GA31473@fargo> <20060427185627.GA30871@electric-eye.fr.zoreil.com> <445144FF.4070703@cantab.net> <20060428075725.GA18957@fargo> <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com>
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

On Apr 28 at 01:58:04, Pekka Enberg wrote:
> Needs some serious coding style cleanup and conversion to proper 2.6
> APIs for starters.

Ok, i could take care of that, and it's a good way of getting my hands
dirty with kernel programming ;). David, if it's ok to you i'll do the
cleanup thing.

What about 2.4/2.2 code? It's supposed to stay for compatibility
or it should be removed before submitting?

cheers,

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
