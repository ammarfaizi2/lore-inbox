Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUDJBGy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 21:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbUDJBGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 21:06:54 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:8900 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261706AbUDJBGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 21:06:53 -0400
Date: Fri, 9 Apr 2004 21:07:10 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make floppy.c readable
In-Reply-To: <20040408204247.5f960859.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.58.0404092104230.16677@montezuma.fsmlabs.com>
References: <20040408204247.5f960859.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2004, Randy.Dunlap wrote:

>
> run scripts/Lindent on drivers/block/floppy.c, but keep some
> nicely-formatted structs (tables) and labels as they were.
>
> Same code generated before and after, except for some __LINE__
> numbers which changed as expected.

I fear the consequences of making any comments here. Randy be fairly
certain all of this hard work won't go unrewarded ;)
