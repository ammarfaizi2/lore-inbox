Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVEAMvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVEAMvg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 08:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVEAMvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 08:51:36 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:32143 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261490AbVEAMvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 08:51:35 -0400
Date: Sun, 1 May 2005 14:51:32 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2
Message-ID: <20050501125132.GC9739@ens-lyon.fr>
References: <200505011010.j41AA1dC026127@harpo.it.uu.se> <20050501102737.GB9739@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050501102737.GB9739@ens-lyon.fr>
User-Agent: Mutt/1.5.8i
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2005 at 12:27:37PM +0200, Benoit Boissinot wrote:
> On Sun, May 01, 2005 at 12:10:01PM +0200, Mikael Pettersson wrote:
> > On Sun, 1 May 2005 02:27:49 +0200, Benoit Boissinot wrote:
> > This looks exactly like the effect of the gcc-4.0 miscompilation
> > of net/ipv4/devinet.c I reported 8 days ago.
> > 
> > Are you using gcc-4.0? If so, don't, or at least upgrade to the
> > latest snapshot which should include a fix.
> > 
> 
> Yes i am using gcc-4.0, i will try a newer snapshot as soon as possible.
> 
it runs fine with a newer gcc-4 snapshot

thanks and sorry to bother,

Benoit

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
