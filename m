Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbUCHR7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 12:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbUCHR7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 12:59:22 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:49606 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262693AbUCHR7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 12:59:19 -0500
Date: Mon, 8 Mar 2004 12:59:15 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Redeeman <redeeman@redeeman.linux.dk>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.4-rc2-mm1
In-Reply-To: <1078768312.5724.17.camel@redeeman.linux.dk>
Message-ID: <Pine.LNX.4.58.0403081257170.29087@montezuma.fsmlabs.com>
References: <20040308174109.GA784@balram.gotdns.org> <1078768312.5724.17.camel@redeeman.linux.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2004, Redeeman wrote:

> On Mon, 2004-03-08 at 18:41, Balram Adlakha wrote:
> > Was the DMA patch for CDROMREADAUDIO reading? I don't seem any speed
> > increase while ripping with cdparanoia.
> i didnt notice anything either, but that is because mine went to 32x
> anyway, which is my cdrom maximum ;)

How about CPU utilisation? vmstat output should do the trick.

	Zwane

