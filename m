Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWJIPzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWJIPzc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 11:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWJIPzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 11:55:32 -0400
Received: from smtp20.orange.fr ([193.252.22.29]:28157 "EHLO
	smtp-msa-out20.orange.fr") by vger.kernel.org with ESMTP
	id S932444AbWJIPza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 11:55:30 -0400
X-ME-UUID: 20061009155529200.30E681C0008A@mwinf2018.orange.fr
Date: Tue, 10 Oct 2006 02:10:43 +0300
From: Samuel Ortiz <samuel@sortiz.org>
To: Komal Shah <komal_shah802003@yahoo.com>, tony@atomide.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Missed OMAP IrDA patch for 2.6.19?
Message-ID: <20061009231042.GC4696@sortiz.org>
Reply-To: Samuel Ortiz <samuel@sortiz.org>
References: <20061005170906.22410.qmail@web37915.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005170906.22410.qmail@web37915.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Komal,

On Thu, Oct 05, 2006 at 10:09:06AM -0700, Komal Shah wrote:
> Samuel,
> 
> Why the following patch never made it to -mm tree
> OR to your IrDA tree for considering under 2.6.19?
I had another look at the patch, and I just saw that it depends on
GPIOEXPANDER_OMAP. This symbol is currently only defined in Tony's tree, so
it would make more sense for Tony to push it there first.

Tony, can you push this patch to your tree ? I ACKed it after the second
iteration.

Cheers,
Samuel.


> http://lkml.org/lkml/2006/8/27/141
> 
> 
> 
> ---Komal Shah
> http://komalshah.blogspot.com/
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
