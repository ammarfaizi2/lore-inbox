Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbVHaWHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbVHaWHV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 18:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbVHaWHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 18:07:21 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:48798 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S964921AbVHaWHU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 18:07:20 -0400
X-ORBL: [67.124.117.85]
Date: Wed, 31 Aug 2005 15:07:17 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, Andrew Morton <akpm@osdl.org>,
       SYSLINUX@zytor.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
Message-ID: <20050831220717.GA14625@taniwha.stupidest.org>
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com> <20050831215757.GA10804@taniwha.stupidest.org> <431628D5.1040709@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431628D5.1040709@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 03:01:57PM -0700, H. Peter Anvin wrote:

> Maybe not.  Another option would simply be to bump it up
> significantly (2x isn't really that much.)  4096, maybe.

I wonder if we're not at the point where we need something different
to what we have now.  The concept of a command-line works for passing
simple state but for more complex things it's too cumbersome.
