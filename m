Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWC1EOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWC1EOF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 23:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWC1EOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 23:14:04 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:6151 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751095AbWC1EOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 23:14:03 -0500
Date: Tue, 28 Mar 2006 06:14:00 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Mike Galbraith <efault@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: scheduler starvation resistance patches for 2.6.16
Message-ID: <20060328041400.GJ21493@w.ods.org>
References: <1143434125.17567.11.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143434125.17567.11.camel@homer>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 06:35:25AM +0200, Mike Galbraith wrote:
> Greetings,
> 
> Knowing that not everybody runs the latest/greatest mm kernels, I've
> adapted my scheduler starvation resistance tree to virgin 2.6.16.  Those
> interested will find seven patches in the attached tarball.
> 
> Test feedback much appreciated.

Thanks Mike.

It will be easier to test, and I'll try to convince some people around
me to give it a try. Do you expect the exact same behaviour as in -mm ?

Regards,
Willy

