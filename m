Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSLOX10>; Sun, 15 Dec 2002 18:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbSLOX1Z>; Sun, 15 Dec 2002 18:27:25 -0500
Received: from [195.208.223.245] ([195.208.223.245]:65152 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263246AbSLOX1Z>; Sun, 15 Dec 2002 18:27:25 -0500
Date: Mon, 16 Dec 2002 02:35:02 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Tom Vier <tmv@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 smp on alpha won't boot
Message-ID: <20021216023502.A1953@localhost.park.msu.ru>
References: <20021206021638.GA357@yzero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021206021638.GA357@yzero>; from tmv@comcast.net on Thu, Dec 05, 2002 at 09:16:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 09:16:38PM -0500, Tom Vier wrote:
> my dual 667mhz up2000+ will not boot 2.4.20 when compiled w/ smp support. it
> dies, killing the idle task after trying to access virt addr 0, just after
> the slab info is printed. 

Can you reproduce that with 2.4.21-pre1?
If so, the oops, .config and so on are welcomed.

Ivan.
