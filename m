Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265525AbUBAWmy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 17:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265532AbUBAWmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 17:42:54 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:64234 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S265525AbUBAWmw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 17:42:52 -0500
Date: Mon, 2 Feb 2004 00:42:48 +0200 (EET)
From: =?iso-8859-1?Q?Markus_H=E4stbacka?= <midian@ihme.org>
X-X-Sender: midian@midi
To: David Weinehall <tao@acc.umu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: Uptime counter
In-Reply-To: <20040201221900.GE15492@khan.acc.umu.se>
Message-ID: <Pine.LNX.4.44.0402020041350.7645-100000@midi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Feb 2004, David Weinehall wrote:

> On Mon, Feb 02, 2004 at 12:07:40AM +0200, Markus Hästbacka wrote:
[..snip..]
>
> Well, since most of the changes in the latest kernels involve
> networking, trying it with various different network-adapters would be
> interesting, and stress-testing the network-code in general.
>
> If you have the hardware or a really good confidence, a recent
> 2.2-kernel to compare with and sufficient knowledge of C, have a look at
> the network-drivers for a2065 and ariadne, both of which lack the
> padding-fixes the other adapters have, since I didn't want to touch that
> mess...
>
I don't have that hardware to test on, but I can stress test it tomorrow,
give the box a _high_ load, and that way help testing.

Thanks for the suggestions.

	Markus

