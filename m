Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbTIBWkI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 18:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbTIBWkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 18:40:08 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:61322 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261244AbTIBWkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 18:40:05 -0400
Date: Tue, 2 Sep 2003 23:39:57 +0100
From: Jamie Lokier <jamie@shareable.org>
To: James Clark <jimwclark@ntlworld.com>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: Re: Driver Model
Message-ID: <20030902223957.GA17283@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309021420570.5614-100000@cherise> <200309022244.55500.jimwclark@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309022244.55500.jimwclark@ntlworld.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Clark wrote:
> Would a more rigid 'plugin' interface and the concequent move from mainly 
> 'source' modules to binary 'plugins' (still with source-code available for 
> all to see) mean that (a) Kernel was smaller

No, it would undoubtedly make the kernel larger and slower.

> I love Linux but this seems to be holding it back...

Most of the authors of Linux would prefer a little holding back, if
the alternative was widespread binary-only drivers that they couldn't
debug or fix, or learn from, and a slower, larger kernel.

Of course we might be mistaken.

But please take a look at other kernels which _do_ offer a rigid
interface to binary plugins.  Then ask yourself what social phenomena
created the Linux which is exciting and useful as it is, that makes
you want to write drivers for it now instead of those other kernels.

-- Jamie
