Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVCJDLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVCJDLz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 22:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVCJDKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 22:10:43 -0500
Received: from waste.org ([216.27.176.166]:16578 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261472AbVCJDJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 22:09:04 -0500
Date: Wed, 9 Mar 2005 19:08:44 -0800
From: Matt Mackall <mpm@selenic.com>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.11.2
Message-ID: <20050310030844.GA3163@waste.org>
References: <fa.dan38um.1m4gojq@ifi.uio.no> <fa.animhpl.r201hh@ifi.uio.no> <E1D9Ckw-0002C0-8S@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1D9Ckw-0002C0-8S@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 02:46:29AM +0100, Bodo Eggert wrote:
> Bill Davidsen <davidsen@tmr.com> wrote:
> 
> > I think you need both x.y.z=>x.y.z.N and x.y.z.N-1=>x.y.z.N patches. My
> > systems which are following the -stable will just need the most recent,
> > but doing x.y.z-1=>x.y.z.N gets really ugly for higher values of N.
> 
> bzcat ../patch-2.6.nn.[0-9].*|patch -p1

You left out the steps where you fetch them and verify their signatures.

-- 
Mathematics is the supreme nostalgia of our time.
