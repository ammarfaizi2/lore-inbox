Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbVITStD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbVITStD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbVITSsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:48:43 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65292 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965071AbVITSsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:48:17 -0400
Date: Tue, 20 Sep 2005 19:48:02 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sean <seanlkml@sympatico.ca>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: Arrr! Linux v2.6.14-rc2
Message-ID: <20050920184802.GE493@flint.arm.linux.org.uk>
Mail-Followup-To: Sean <seanlkml@sympatico.ca>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <seanlkml@sympatico.ca> <BAYC1-PASMTP04AB35B0A82E89B341AB0BAE950@cez.ice> <56402.10.10.10.28.1127229646.squirrel@linux1> <200509201759.j8KHxkbj000577@laptop11.inf.utfsm.cl> <59258.10.10.10.28.1127241246.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59258.10.10.10.28.1127241246.squirrel@linux1>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 02:34:06PM -0400, Sean wrote:
> On Tue, September 20, 2005 1:59 pm, Horst von Brand said:
> 
> > Only that it doesn't work either today. Kernel stays at 2.6.14-rc1 as of
> > yesterday (latest were a few NTFS patches), everything up to date.
> 
> Yeah, Russell pointed the same thing out a bit earlier.  There are 13
> commits MIA.
> 
> > BTW, the cogito repository is hosed, cg-update can't get needed object
> > 69ba00668be16e44cae699098694286f703ec61d. Fetching the contents by rsync
> > gives the same mess.
> 
> For simply tracking the kernel there isn't much reason to use cogito. 
> Using native git means fewer problems right now since both cogito and git
> are developing quickly with inevitable version skew etc..

Also note that the public git repository is probably suffering from
the same problem as the lack of -rc2.  I wonder whether anyone's
reported it to the ftp admins yet (if it hasn't been fixed)?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
