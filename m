Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbTD3IcG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 04:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTD3IcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 04:32:06 -0400
Received: from vitelus.com ([64.81.243.207]:34824 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S261163AbTD3IcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 04:32:06 -0400
Date: Wed, 30 Apr 2003 01:43:12 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Daniel Phillips <dphillips@sistina.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-ID: <20030430084312.GB6035@vitelus.com>
References: <200304300446.24330.dphillips@sistina.com> <20030430071907.GA30999@alpha.home.local> <20030430083607.GA6035@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030430083607.GA6035@vitelus.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 01:36:07AM -0700, Aaron Lehmann wrote:
> > ==== gcc 3.2.3 -march=i686 -O3 / Pentium 4 / 2.0 GHz ====
> 
> This version of gcc accepts -march=pentium4, which again might make
> gcc's behavior less bizarre.

Oh, you tried that too, sorry.
