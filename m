Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751926AbWAOM44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbWAOM44 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 07:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbWAOM44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 07:56:56 -0500
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:21728 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751926AbWAOM4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 07:56:55 -0500
From: Con Kolivas <kernel@kolivas.org>
To: hugo vanwoerkom <hugovanwoerkom@yahoo.com>
Subject: Re: [ck] 2.6.15-ck2
Date: Sun, 15 Jan 2006 23:56:51 +1100
User-Agent: KMail/1.9
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
References: <20060115125219.16012.qmail@web53315.mail.yahoo.com>
In-Reply-To: <20060115125219.16012.qmail@web53315.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601152356.51578.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 January 2006 23:52, hugo vanwoerkom wrote:
> --- Con Kolivas <kernel@kolivas.org> wrote:
>
> <snip>
>
> > *NOTE*
> > If you're looking for the 1GB lowmem option it has
> > been replaced and you
> > should choose the following in menuconfig for the
> > same effect:
> > ( ) 3G/1G user/kernel split
> > (X) 3G/1G user/kernel split (for full 1G low memory)
> > ( ) 2G/2G user/kernel split
> > ( ) 1G/3G user/kernel split
>
> <snip>
>
> When I have 1GB of memory, the option before was
> clear.
> What this now means, who knows... :-(
> And there is no help for the options.

I'm sorry. This is the patch from mainline and it was already argued on the lk 
mailing list. This is what is in -mm and going into the vanilla kernel in the 
future. The help text does not come up in menuconfig I realise but that's why 
I pointed it out here.

Con
