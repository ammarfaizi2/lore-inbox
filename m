Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWAOXrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWAOXrS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 18:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWAOXrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 18:47:18 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:40832 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750997AbWAOXrR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 18:47:17 -0500
Date: Sun, 15 Jan 2006 15:51:25 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: CaT <cat@zip.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.15.1
Message-ID: <20060115235125.GN3335@sorel.sous-sol.org>
References: <20060115070440.GH3335@sorel.sous-sol.org> <20060115080803.GJ2035@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060115080803.GJ2035@zip.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* CaT (cat@zip.com.au) wrote:
> Was there a fix for the 2.6.16 cfq issues? It's a bad idea for me to use
> AS on servers as it does weird things on the hardware we have (as I've
> previously reported).

There's one relevant fix queued up for next -stable from
this thread:

http://marc.theaimsgroup.com/?t=113657885100003&r=1&w=2

Is that what you're referring to?

thanks,
-chris
