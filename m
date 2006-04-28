Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965088AbWD1LwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbWD1LwE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 07:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbWD1LwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 07:52:04 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:6815 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965088AbWD1LwC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 07:52:02 -0400
Date: Fri, 28 Apr 2006 14:51:58 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: "David =?utf-8?B?R8OzbWV6?=" <david@pleyades.net>
cc: David Vrabel <dvrabel@cantab.net>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: IP1000 gigabit nic driver
In-Reply-To: <20060428113755.GA7419@fargo>
Message-ID: <Pine.LNX.4.58.0604281445590.19801@sbz-30.cs.Helsinki.FI>
References: <20060427142939.GA31473@fargo> <20060427185627.GA30871@electric-eye.fr.zoreil.com>
 <445144FF.4070703@cantab.net> <20060428075725.GA18957@fargo>
 <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com>
 <20060428113755.GA7419@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 28 at 01:58:04, Pekka Enberg wrote:
> > Needs some serious coding style cleanup and conversion to proper 2.6
> > APIs for starters.

On Fri, 28 Apr 2006, David Gómezz wrote:
> Ok, i could take care of that, and it's a good way of getting my hands
> dirty with kernel programming ;). David, if it's ok to you i'll do the
> cleanup thing.
> 
> What about 2.4/2.2 code? It's supposed to stay for compatibility
> or it should be removed before submitting?

It's preferred not to have compatability cruft for 2.6 patch submissions, 
so I'd say kill them.

					Pekka
