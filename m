Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbTCFXgN>; Thu, 6 Mar 2003 18:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261293AbTCFXgM>; Thu, 6 Mar 2003 18:36:12 -0500
Received: from pizda.ninka.net ([216.101.162.242]:29381 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261289AbTCFXfV>;
	Thu, 6 Mar 2003 18:35:21 -0500
Date: Thu, 06 Mar 2003 15:27:03 -0800 (PST)
Message-Id: <20030306.152703.21845381.davem@redhat.com>
To: cw@f00f.org
Cc: yoshfuji@linux-ipv6.org, kazunori@miyazawa.org, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, usagi@linux-ipv6.org
Subject: Re: (usagi-core 12294) Re: [PATCH] IPv6 IPsec support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030306213217.GA6358@f00f.org>
References: <20030306.004820.41101302.yoshfuji@linux-ipv6.org>
	<20030305.154100.28816301.davem@redhat.com>
	<20030306213217.GA6358@f00f.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Chris Wedgwood <cw@f00f.org>
   Date: Thu, 6 Mar 2003 13:32:17 -0800
   
   Actually... at that point being able to monitor updates to the
   flow-cache would be useful for various statistical purposes and
   applications, especially if the flow cache was able to periodically
   export utilization counters...
   
It will keep statistics, just like the route cache keeps
them now.
   
