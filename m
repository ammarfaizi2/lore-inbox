Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVAZACP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVAZACP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVAYX7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:59:39 -0500
Received: from news.suse.de ([195.135.220.2]:12209 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262247AbVAYX6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:58:50 -0500
Date: Wed, 26 Jan 2005 00:58:37 +0100 (CET)
From: Gerald Pfeifer <gp@suse.de>
To: Sachithanantham_Saravanan@emc.com
Cc: linux-ia64@vger.kernel.org, yakker@sgi.com, yakker@turbolinux.com,
       yakker@alacritech.com, matt@aparity.com, linux-kernel@vger.kernel.org
Subject: Re: LKCD on 2.6 IA64 Linux Kernel
In-Reply-To: <50C05B7AA7D6924FB5E384EF14BC647BCBBD63@inba1mx2.corp.emc.com>
Message-ID: <Pine.LNX.4.61.0501260050240.26713@lifschitz.suse.de>
References: <50C05B7AA7D6924FB5E384EF14BC647BCBBD63@inba1mx2.corp.emc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 Sachithanantham_Saravanan@emc.com wrote:
> I tried using lkcd on a ia64 machine running on 2.6.5-7.111 SuSe Kernel for
> debugging.

I strongly recommend you switch to 2.6.5-7.139 (or later) which is the
SLES9 SP1 kernel as opposed to the SLES9 GA kernel.  The former has quite
some changes wrt. LKCD and SLES9 SP1 also comes with a updated lkcdutils.

Furthermore, this is probably more of an issue you may want to discuss 
with your contacts at SUSE/Novell rather than on the linux-ia64 list,
though if there's interest I'll be happy to post pointers to these kernel
and lkcdutils packages.

Gerald
