Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUEOTQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUEOTQd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 15:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbUEOTQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 15:16:33 -0400
Received: from gwyn.tux.org ([199.184.165.135]:39125 "EHLO gwyn.tux.org")
	by vger.kernel.org with ESMTP id S262009AbUEOTQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 15:16:30 -0400
Date: Sat, 15 May 2004 15:15:13 -0400 (EDT)
From: Samuel S Chessman <chessman@tux.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: <tlan-devel@lists.sourceforge.net>, <jgarzik@pobox.com>,
       <linux-net@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Tlan-devel] [2.6 patch] fix tlan.c for !PCI
In-Reply-To: <20040512235115.GE21408@fs.tum.de>
Message-ID: <Pine.LNX.4.30.0405151512170.12707-100000@gwyn.tux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004, Adrian Bunk wrote:

> I got the following compile error in 2.6.6-mm1 (but it's not specific to
> -mm) with CONFIG_PCI=n:

<snip/>

> The patch below fixes this issue.
>
> Please apply
> Adrian

<snip/>

Thanks for the patch, Adrian.
I will get to this as soon as my day job allows.
Sam

-- 
   Sam Chessman                                         chessman (a) tux.org
    First do what's necessary, then what's possible, finally the impossible.

