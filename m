Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbUARV5V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 16:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264141AbUARV5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 16:57:21 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:7392 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264137AbUARV5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 16:57:20 -0500
Date: Sun, 18 Jan 2004 13:57:11 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ryan Reich <ryanr@uchicago.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Overlapping MTRRs in 2.6.1
Message-ID: <20040118215711.GE1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Ryan Reich <ryanr@uchicago.edu>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0401181458080.2194@ryanr.aptchi.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401181458080.2194@ryanr.aptchi.homelinux.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 18, 2004 at 03:11:27PM -0600, Ryan Reich wrote:
> My video card is a Radeon 7000, 64M of memory; processor, Athlon 2600+;
> motherboard, Shuttle AN35N with NForce2 chipset.

Can you try a few -mm kernels and see if there is any improvement?  Also,
did you get any problems with 2.6.0?
