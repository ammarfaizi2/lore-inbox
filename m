Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUCCFvf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 00:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUCCFvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 00:51:35 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:43204 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262382AbUCCFvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 00:51:33 -0500
Date: Wed, 3 Mar 2004 00:51:26 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] kpatchup 0.02 kernel patching script
In-Reply-To: <20040303022444.GA3883@waste.org>
Message-ID: <Pine.LNX.4.58.0403030050340.29087@montezuma.fsmlabs.com>
References: <20040303022444.GA3883@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2004, Matt Mackall wrote:

> This is the first release of kpatchup, a script for managing switching
> between kernel releases via patches with some smarts:
>
>  - understands -pre and -rc version numbering
>  - aware of various external trees
>  - automatically patch between any tree in an x.y release
>  - automatically download and cache patches on demand
>  - automatically determine the latest patch in various series
>  - optionally print version strings or URLs for patches
>
> Currently it knows about 2.4, 2.4-pre, 2.6, 2.6-pre, 2.6-bk, 2.6-mm,
> and 2.6-tiny.

Oh i definitely owe you one now, this is replacing the ugly shell script i
had before, i'm mostly using this now to download and patch up trees
before cvs import'ing them.

Thanks!

