Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265541AbTAFAjz>; Sun, 5 Jan 2003 19:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265564AbTAFAjz>; Sun, 5 Jan 2003 19:39:55 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:57584 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S265541AbTAFAjz>;
	Sun, 5 Jan 2003 19:39:55 -0500
Date: Sun, 5 Jan 2003 19:48:16 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: linux-kernel@vger.kernel.org, orinoco-users@lists.sourceforge.net,
       dhinds@sonic.net
Subject: Re: [Orinoco-users] [PATCH] orinoco_plx-0.13b backport to kernel 2.2
Message-ID: <20030106004816.GA25837@www.kroptech.com>
References: <20030105231921.GA7294@www.kroptech.com> <20030106000929.GC18808@zax.zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030106000929.GC18808@zax.zax>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 11:09:29AM +1100, David Gibson wrote:
> On Sun, Jan 05, 2003 at 06:19:21PM -0500, Adam Kropelin wrote:
> > working well. I've updated it to the latest (testing, beta) version of
> > the orinoco_plx driver (0.13b) and the latest version of pcmcia-cs (3.2.3).
> 
> Eck... be aware that the "testing" version, although labelled 0.13b
> may not be the final 0.13b version.

Yup, understood. I'll update the backport as necessary. Just wanted to
start from the most recent code base available, even if it's still in
flux. I would have gone with 0.13a but a couple bugfixes in 0.13b seemed
worth having.

--Adam

