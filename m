Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbUK1I3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUK1I3P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 03:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbUK1I3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 03:29:15 -0500
Received: from levante.wiggy.net ([195.85.225.139]:50351 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261411AbUK1I3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 03:29:13 -0500
Date: Sun, 28 Nov 2004 09:29:12 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Suspend 2 merge
Message-ID: <20041128082912.GC22793@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20041127220752.16491.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041127220752.16491.qmail@science.horizon.com>
User-Agent: Mutt/1.5.6+20040722i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously linux@horizon.com wrote:
> Lucky you.  My machine takes minutes.
> (To be precise, it prints about a line and a half of dots in the
> count_data_pages() loop, and often takes 2 seconds per dot.)

It also seems to vary wildly. Most of the time it goes pretty fast for
me (under one minute) but occasionaly it will take well over 10 minutes.
Never managed to time it exactly since my battery tends to run out in
the middle of a suspend when that happens.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
