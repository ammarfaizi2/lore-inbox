Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbVHaV6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbVHaV6S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 17:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbVHaV6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 17:58:17 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:24454 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S932537AbVHaV6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 17:58:16 -0400
X-ORBL: [67.124.117.85]
Date: Wed, 31 Aug 2005 14:57:57 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, Andrew Morton <akpm@osdl.org>,
       SYSLINUX@zytor.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
Message-ID: <20050831215757.GA10804@taniwha.stupidest.org>
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43162148.9040604@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 02:29:44PM -0700, H. Peter Anvin wrote:

> I think someone on the SYSLINUX mailing list already sent a patch to
> akpm to make 512 the default; making it configurable would be a
> better idea.  Feel free to send your patch through me.

So we really need this to be a configuration option?  We have too many
of those already.
