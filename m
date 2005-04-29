Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVD2Fn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVD2Fn4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 01:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVD2Fn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 01:43:56 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:45498 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S262388AbVD2Fnz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 01:43:55 -0400
X-ORBL: [67.124.119.21]
Date: Thu, 28 Apr 2005 22:43:51 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Gilles Pokam <gpokam@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel memory
Message-ID: <20050429054351.GA12654@taniwha.stupidest.org>
References: <ba83582205042816522e2a7a93@mail.gmail.com> <20050429030313.GA10344@taniwha.stupidest.org> <ba8358220504282233754de43b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba8358220504282233754de43b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 10:33:16PM -0700, Gilles Pokam wrote:

> I was thinking of making the whole memory accessible to handle this.
> But I can not rely on mapping /dev/mem or /proc/kcore into the user
> space since this would require modifying the binary. Are there other
> ways of doing this ? May be disabling paging ? if so, how to do this
> ?

why can't you use a wrapper?

