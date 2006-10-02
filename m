Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbWJBRgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbWJBRgx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWJBRgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:36:53 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:42716 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965168AbWJBRgw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:36:52 -0400
Subject: Re: [Ops] 2.6.18
From: john stultz <johnstul@us.ibm.com>
To: caglar@pardus.org.tr
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
In-Reply-To: <200610010332.52509.caglar@pardus.org.tr>
References: <200610010332.52509.caglar@pardus.org.tr>
Content-Type: text/plain; charset=utf-8
Date: Mon, 02 Oct 2006 10:36:45 -0700
Message-Id: <1159810605.5873.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-01 at 03:32 +0300, S.Çağlar Onur wrote:
> Hi;
> 
> Here [1] are the two different panics with 2.6.18 on vmware, its reproducable 
> on every 4-5 reboot [same config/kernel in "2.6.18 Nasty Lockup" thread, so i 
> CC'd to that thread's posters also]
> 
> [1] http://cekirdek.pardus.org.tr/~caglar/2.6.18/

Hmmm.. That first oops looks interesting to me.

When you say they're reproducible every 4-5 reboots, which one do you
mean?

thanks
-john


