Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWBFWvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWBFWvq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWBFWvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:51:45 -0500
Received: from detroit.securenet-server.net ([209.51.153.26]:46248 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S932414AbWBFWvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:51:44 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: "Michael Kerrisk" <mtk-manpages@gmx.net>
Subject: Re: man-pages-2.22 is released
Date: Mon, 6 Feb 2006 14:51:36 -0800
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
References: <16806.1139255986@www031.gmx.net>
In-Reply-To: <16806.1139255986@www031.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602061451.37028.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 6, 2006 11:59 am, Michael Kerrisk wrote:
> This is a request to kernel developers: if you make a change
> to a kernel-userland interface, or observe a discrepancy
> between the manual pages and reality, would you please send
> me (at mtk-manpages@gmx.net ) one of the following
> (in decreasing order of preference):

Wouldn't it be easier for you to keep them up to date if sections 2, 4, 
and parts of 5 were included in the kernel source tree?  Documentation 
updates could be enforced as part of the patch process--all you'd have 
to do is NAK patches that modified userland interfaces if they didn't 
contain documentation updates (and I'm sure others would help you with 
that task).

Likewise with the glibc stuff.  Doesn't it belong with the glibc project?  
Wouldn't that make more sense, both from a packaging and maintenance 
perspective?

Either way, thanks a lot for keeping the pages in good shape, it's much 
appreciated.

Thanks,
Jesse
