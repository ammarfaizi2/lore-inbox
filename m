Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbUDKRQb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 13:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbUDKRQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 13:16:31 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:53700 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262427AbUDKRQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 13:16:30 -0400
Date: Sun, 11 Apr 2004 13:16:49 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] ketchup 0.5 (formerly kpatchup)
In-Reply-To: <20040411080515.GX6248@waste.org>
Message-ID: <Pine.LNX.4.58.0404111313410.16677@montezuma.fsmlabs.com>
References: <20040411080515.GX6248@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Apr 2004, Matt Mackall wrote:

> ketchup is a script that automatically patches between kernel
> versions, downloading and caching patches as needed, and automatically
> determining the latest versions of several trees. Example usage:

Tiny feature request, could you add support for untarring base trees too
so all you'd specify is ketchup 2.6.6 and it'd look for a base tree in
$KETCHUP_ARCH if the current working directory isn't a kernel tree.

Thanks again for the script

