Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316823AbSGHID0>; Mon, 8 Jul 2002 04:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316824AbSGHID0>; Mon, 8 Jul 2002 04:03:26 -0400
Received: from ns.suse.de ([213.95.15.193]:23052 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316823AbSGHIDZ>;
	Mon, 8 Jul 2002 04:03:25 -0400
Date: Mon, 8 Jul 2002 10:05:56 +0200
From: Andi Kleen <ak@suse.de>
To: Madhavi <madhavis@sasken.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: IPv6 multiple routing tables
Message-ID: <20020708100556.A20528@wotan.suse.de>
References: <p737kk6wueb.fsf@oldwotan.suse.de> <Pine.LNX.4.33.0207081322320.1324-100000@pcz-madhavis.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0207081322320.1324-100000@pcz-madhavis.sasken.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2002 at 01:24:01PM +0530, Madhavi wrote:
> 
> Hi
> 
> Could you tell me where the patch is available. I just need to get an idea
> on how it is implemented.

The code is in the standard kernel, inside CONFIG_IPV6_SUBTREES


-Andi
