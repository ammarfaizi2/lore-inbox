Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274888AbTHKXz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 19:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274903AbTHKXz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 19:55:59 -0400
Received: from imf.math.ku.dk ([130.225.103.32]:58290 "EHLO imf.math.ku.dk")
	by vger.kernel.org with ESMTP id S274888AbTHKXz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 19:55:58 -0400
Date: Tue, 12 Aug 2003 01:55:56 +0200 (CEST)
From: Peter Berg Larsen <pebl@math.ku.dk>
To: n0p n0p <n0px90@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: cpu fan (acpi)
In-Reply-To: <BAY1-F142BBDNfaOR6D00033331@hotmail.com>
Message-ID: <Pine.LNX.4.40.0308120148220.14424-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Aug 2003, n0p n0p wrote:

> Sometime, the fan of my dell laptop goes to speed 3 even if the
> temperature of the cpu is low.

I had the same experience with a dell i8000, but a bios upgrade fixed
that:  (from i8000a22.txt)

The following updates were made to the A19 BIOS to create A20:
...
3.  Fixed issue in which the fans may remain on high speed constantly.
...


