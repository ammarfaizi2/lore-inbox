Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313119AbSDDJmp>; Thu, 4 Apr 2002 04:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313120AbSDDJmf>; Thu, 4 Apr 2002 04:42:35 -0500
Received: from are.twiddle.net ([64.81.246.98]:61337 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S313119AbSDDJmb>;
	Thu, 4 Apr 2002 04:42:31 -0500
Date: Thu, 4 Apr 2002 01:42:23 -0800
From: Richard Henderson <rth@twiddle.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: "David S. Miller" <davem@redhat.com>, tim@birdsnest.maths.tcd.ie,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.7
Message-ID: <20020404014223.A22363@twiddle.net>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	"David S. Miller" <davem@redhat.com>, tim@birdsnest.maths.tcd.ie,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020330.182243.88963096.davem@redhat.com> <Pine.GSO.4.21.0203310253360.4431-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2002 at 02:54:14AM -0500, Alexander Viro wrote:
> + * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
> + * but it doesn't work on sparc64, so we just do it by hand

Rather, "the ancient version of gcc commonly used on sparc64".


r~
