Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264802AbSKEIIR>; Tue, 5 Nov 2002 03:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264803AbSKEIIR>; Tue, 5 Nov 2002 03:08:17 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:1796 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S264802AbSKEIIR>;
	Tue, 5 Nov 2002 03:08:17 -0500
Date: Tue, 5 Nov 2002 09:14:29 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Bert Barbe <BERT.BARBE@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.20-rc1} multiple arp_ip_targets in bonding module
Message-ID: <20021105081429.GA879@alpha.home.local>
References: <8121326.1036463658571.JavaMail.nobody@web55.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8121326.1036463658571.JavaMail.nobody@web55.us.oracle.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Mon, Nov 04, 2002 at 06:34:18PM -0800, Bert Barbe wrote:
> Hi,
> 
> I posted this patch some time ago for discussion but didnt see any response,
> so now I'd like to submit it for inclusion in the 2.4 kernel. As mentioned in
> the subject this patch has been based on 2.4.20-rc1

I think that your should post this patch to people working on the bonding
project, since there are other pending patches. I used to be one of them, but
really don't have time anymore. Please take a look at :

	http://sf.net/projects/bonding/

Anyway, I agree that your patch is useful for several situations, mainly cases
of dual attachment to a lan with 2 routers (master/slave), and I too would like
to get it in a future kernel. But it's a new feature and we're in -rc now, so
may be we'll have to wait for 2.4.21pre.

Cheers,
Willy

