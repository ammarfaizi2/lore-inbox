Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbTABPxV>; Thu, 2 Jan 2003 10:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262360AbTABPxV>; Thu, 2 Jan 2003 10:53:21 -0500
Received: from dp.samba.org ([66.70.73.150]:19078 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262326AbTABPxU>;
	Thu, 2 Jan 2003 10:53:20 -0500
Date: Fri, 3 Jan 2003 02:58:08 +1100
From: Anton Blanchard <anton@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][COMPAT] Eliminate the rest of the __kernel_..._t32 typedefs 1/7 PPC64
Message-ID: <20030102155808.GF12395@krispykreme>
References: <20021230171959.63ea2d5d.sfr@canb.auug.org.au> <20021230172529.3acc863f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021230172529.3acc863f.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This includes that compat_..stat and compat_times calls and fixes a
> (pseudo) bug where the compatibility loff_t was defined as int (instead
> of signed 64 bit).

Thanks Stephen, Ive applied the ppc64 bits.

Anton
