Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268384AbTCFVVp>; Thu, 6 Mar 2003 16:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268391AbTCFVVp>; Thu, 6 Mar 2003 16:21:45 -0500
Received: from tapu.f00f.org ([202.49.232.129]:52400 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S268384AbTCFVVo>;
	Thu, 6 Mar 2003 16:21:44 -0500
Date: Thu, 6 Mar 2003 13:32:17 -0800
From: Chris Wedgwood <cw@f00f.org>
To: "David S. Miller" <davem@redhat.com>
Cc: yoshfuji@linux-ipv6.org, kazunori@miyazawa.org, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, usagi@linux-ipv6.org
Subject: Re: (usagi-core 12294) Re: [PATCH] IPv6 IPsec support
Message-ID: <20030306213217.GA6358@f00f.org>
References: <20030305233025.784feb00.kazunori@miyazawa.org> <20030305.072149.121185037.davem@redhat.com> <20030306.004820.41101302.yoshfuji@linux-ipv6.org> <20030305.154100.28816301.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030305.154100.28816301.davem@redhat.com>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 03:41:00PM -0800, David S. Miller wrote:

> Note that this coincides with the idea to eventually have an
> address-family independant flow cache.

Actually... at that point being able to monitor updates to the
flow-cache would be useful for various statistical purposes and
applications, especially if the flow cache was able to periodically
export utilization counters...


  --cw
