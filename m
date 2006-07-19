Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWGSX7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWGSX7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 19:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWGSX7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 19:59:15 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:29924 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S964876AbWGSX7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 19:59:14 -0400
Date: Wed, 19 Jul 2006 19:58:35 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>
Cc: linux-kernel@vger.kernel.org, kyle@parisc-linux.org,
       twoller@crystal.cirrus.com, James@superbug.demon.co.uk, zab@zabbo.net,
       sailer@ife.ee.ethz.ch, perex@suse.cz, zaitcev@yahoo.com
Subject: Re: [PATCH] sound: Conversions from kmalloc+memset to k(z|c)alloc.
Message-ID: <20060719235835.GA4235@athena.road.mcmartin.ca>
References: <20060719005455.GB30823@lumumba.uhasselt.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060719005455.GB30823@lumumba.uhasselt.be>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 02:54:55AM +0200, Panagiotis Issaris wrote:
>  sound/oss/ad1889.c              |    3 +--
> 

Acked-By: Kyle McMartin <kyle@parisc-linux.org>
