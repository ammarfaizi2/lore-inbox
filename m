Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267495AbTACLZX>; Fri, 3 Jan 2003 06:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267497AbTACLZX>; Fri, 3 Jan 2003 06:25:23 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:30163 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267495AbTACLZX>;
	Fri, 3 Jan 2003 06:25:23 -0500
Date: Fri, 3 Jan 2003 11:31:36 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: odd phenomenon.
Message-ID: <20030103113136.GD2567@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	William Lee Irwin III <wli@holomorphy.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030103103816.GA2567@codemonkey.org.uk> <20030103104809.GD9704@holomorphy.com> <20030103110901.GC2567@codemonkey.org.uk> <20030103111253.GE9704@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030103111253.GE9704@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 03:12:53AM -0800, William Lee Irwin III wrote:
 > > That was my first thought. Everything works as expected though
 > > when you try to strace it.
 > Highly unusual.

Indeed.

 > In-kernel tracing seems to be in order. Can you
 > describe a more complete "reproduction suite" (esp. app/lib versions)?

Galeon 1.2.7, Bitkeeper 3.0 20021011025136

I had until today thought that this was a 2.5 only bug, but this
box rebooted back into a 2.4 kernel yesterday for the first time
in ages. (Running 2.4.20-rc4 currently)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
