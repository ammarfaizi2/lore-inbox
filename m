Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265122AbUGBX5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265122AbUGBX5k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 19:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265109AbUGBX5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 19:57:39 -0400
Received: from are.twiddle.net ([64.81.246.98]:19853 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S265111AbUGBX50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 19:57:26 -0400
Date: Fri, 2 Jul 2004 16:56:23 -0700
From: Richard Henderson <rth@twiddle.net>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove drivers/char/h8.{c,h}
Message-ID: <20040702235623.GA1867@twiddle.net>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	linux-kernel@vger.kernel.org
References: <20040702224101.GN28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702224101.GN28324@fs.tum.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 12:41:01AM +0200, Adrian Bunk wrote:
> Since CONFIG_OBSOLETE is never set it is not selectable.
> Is there any reason why this driver should stay in the kernel or would
> you accept a patch that removes this driver?

Kill it.


r~
