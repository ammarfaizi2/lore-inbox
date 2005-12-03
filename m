Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVLCU75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVLCU75 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 15:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVLCU75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 15:59:57 -0500
Received: from gate.in-addr.de ([212.8.193.158]:42134 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1750722AbVLCU75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 15:59:57 -0500
Date: Sat, 3 Dec 2005 21:59:11 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203205911.GX18919@marowsky-bree.de>
References: <20051203135608.GJ31395@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051203135608.GJ31395@stusta.de>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-12-03T14:56:08, Adrian Bunk <bunk@stusta.de> wrote:

> The current kernel development model is pretty good for people who 
> always want to use or offer their costumers the maximum amount of the 
> latest bugs^Wfeatures without having to resort on additional patches for 
> them.
> 
> Problems of the current development model from a user's point of view 
> are:
> - many regressions in every new release
> - kernel updates often require updates for the kernel-related userspace 
>   (e.g. for udev or the pcmcia tools switch)

Your problem statement is correct, but you're fixing the symptoms, not
the cause.

What we need is an easier way for users to pull in kernel updates with
the matching kernel-related user-space.

This is provided, though with some lag, by Fedora, openSUSE, Debian
testing, dare I say gentoo and others.

The right way to address this is to work with the distribution of your
choice to make these updates available faster.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

