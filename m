Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264677AbSLLRPI>; Thu, 12 Dec 2002 12:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbSLLRPI>; Thu, 12 Dec 2002 12:15:08 -0500
Received: from dsl092-013-071.sfo1.dsl.speakeasy.net ([66.92.13.71]:21686 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id <S264677AbSLLRPH>; Thu, 12 Dec 2002 12:15:07 -0500
Subject: Re: using 2 TB  in real life
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Mike Black <mblack@csi-inc.com>
Cc: Anders Henke <anders.henke@sysiphus.de>, linux-kernel@vger.kernel.org
In-Reply-To: <029301c2a1d6$85cbe280$f6de11cc@black>
References: <20021212111237.GA12143@schlund.de>
	 <029301c2a1d6$85cbe280$f6de11cc@black>
Content-Type: text/plain
Organization: 
Message-Id: <1039713776.16887.4.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 12 Dec 2002 09:22:56 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-12 at 04:03, Mike Black wrote:
> Looks like it's already handled in 2.5.
> Here's a patch for 2.4:
> http://www.gelato.unsw.edu.au/patches-index.html

The result of the device size calculation that Anders complained about
in 2.4.20 was wrong in a different way in Peter's >2TB patch, last I
looked.  I don't think Peter's patch is necessary for a 1.9TB device,
anyway.

	<b

