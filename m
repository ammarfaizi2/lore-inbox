Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUKCWfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUKCWfi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbUKCWX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:23:59 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:53755 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261932AbUKCWH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:07:56 -0500
Date: Wed, 3 Nov 2004 14:07:40 -0800
From: Chris Wedgwood <cw@f00f.org>
To: "Giacomo A. Catenazzi" <cate@debian.org>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
Message-ID: <20041103220740.GA14272@taniwha.stupidest.org>
References: <41894779.10706@techsource.com> <20041103211714.GP12275@mea-ext.zmailer.org> <41894F86.7070405@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41894F86.7070405@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 10:37:10PM +0100, Giacomo A. Catenazzi wrote:

> But is it Linux the biggest compiler bug finder?

for C it might be, obviously not for C++

> So forcing a newer compiler in other architectures should
> improve also the quality of code generation.

assuming there are sufficiently many people to work on gcc and those
platforms (there isn't)
