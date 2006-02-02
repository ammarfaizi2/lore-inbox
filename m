Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWBBLWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWBBLWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWBBLWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:22:41 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:22730 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1750713AbWBBLWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:22:41 -0500
Date: Thu, 2 Feb 2006 13:22:17 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, chris@zankel.net
Subject: Re: [BUG] sizeof(struct async_icount) exported to userspace on SH, SH64 and xtensa
Message-ID: <20060202112217.GA3960@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, chris@zankel.net
References: <20060121185712.GA25185@flint.arm.linux.org.uk> <20060202102708.GD5034@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202102708.GD5034@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 10:27:08AM +0000, Russell King wrote:
> Ping?
> 
Fixed for sh/sh64 in current git, though I forgot to CC you on it.
Thanks for catching this.
