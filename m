Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265612AbTFNEX0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 00:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265613AbTFNEX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 00:23:26 -0400
Received: from windsormachine.com ([206.48.122.28]:50191 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S265612AbTFNEXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 00:23:25 -0400
Date: Sat, 14 Jun 2003 00:37:13 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: generic method to assign IRQs
In-Reply-To: <1055563922.11874.29.camel@rivendell.home.local>
Message-ID: <Pine.LNX.4.33.0306140035560.29854-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jun 2003, Florin Andrei wrote:

> This issue may not matter much on "normal" systems, but it matters a
> whole bunch on multimedia machines. Not being able to untangle like five
> or six devices assigned to the same IRQ may render an otherwise powerful
> system totally unusable for any decent media purpose (i'm talking here
> about simple tasks such as watching movies, not necessarily of
> professional stuff, which is even more demanding).

Some of the problem is that motherboard manufacturers setup their hardware
so that slots HAVE to share IRQ's no matter what you do.  I've seen
motherboards that have shared IRQ's even if there are no cards plugged in.

Mike

