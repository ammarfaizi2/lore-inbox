Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312279AbSCYDBJ>; Sun, 24 Mar 2002 22:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312283AbSCYDBA>; Sun, 24 Mar 2002 22:01:00 -0500
Received: from c17736.belrs2.nsw.optusnet.com.au ([211.28.31.90]:4012 "EHLO
	bozar") by vger.kernel.org with ESMTP id <S312279AbSCYDAy>;
	Sun, 24 Mar 2002 22:00:54 -0500
Date: Mon, 25 Mar 2002 14:00:21 +1100
From: Andre Pang <ozone@algorithm.com.au>
To: linux-kernel@vger.kernel.org
Cc: Steven Walter <srwalter@yahoo.com>
Subject: Re: Screen corruption in 2.4.18
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Steven Walter <srwalter@yahoo.com>
In-Reply-To: <200203192112.WAA09721@jagor.srce.hr> <20020323160647.GA22958@hapablap.dyn.dhs.org> <1016953516.189201.5912.nullmailer@bozar.algorithm.com.au> <200203241507.g2OF7WN26069@ls401.hinet.hr> <1017020598.420771.13343.nullmailer@bozar.algorithm.com.au> <20020325024027.GA23315@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Message-Id: <1017025221.189690.14540.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2002 at 08:40:27PM -0600, Steven Walter wrote:

> I fear this as well.  In fact, I'm relatively certain that they /do/
> both use the same PCI ID.  Hence why lspci lists KT133/KM133.  But I
> hope to big mistaken.  If not, the only way I can see of detecting that
> it is a KM133 is by checking what device 01:00 is an S3 ProSavage.
> Yuck.

Is it possible to identify the KT133/KM133 by the vendor string,
rather than the PCI ID?  It's, erm, kinda ugly, but it might be
the cleanest way to do it if the PCI ID isn't unique.


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
