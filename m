Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTKYR3v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbTKYR3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:29:51 -0500
Received: from home.wiggy.net ([213.84.101.140]:50363 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S262765AbTKYR3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:29:50 -0500
Date: Tue, 25 Nov 2003 18:29:49 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/5] dm: make v4 of the ioctl interface the default
Message-ID: <20031125172949.GE17907@wiggy.net>
Mail-Followup-To: Linux Mailing List <linux-kernel@vger.kernel.org>
References: <20031125162451.GA524@reti> <20031125163313.GD524@reti> <3FC387A0.8010600@backtobasicsmgmt.com> <20031125170503.GG524@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031125170503.GG524@reti>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Joe Thornber wrote:
> For the last few months the tools have supported both v1 and v4
> interfaces, allowing people to roll back to older kernels.

'last few months' is extremely short for a migration path. Can't we
ditch the v1 interface in 2.7 and allow people to migrate slowly?

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

