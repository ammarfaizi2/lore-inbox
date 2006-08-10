Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161159AbWHJSwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbWHJSwT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 14:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161158AbWHJSwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 14:52:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17305 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161163AbWHJSwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 14:52:18 -0400
Date: Thu, 10 Aug 2006 11:49:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: [NTP 8/9] convert to the NTP4 reference model
Message-Id: <20060810114903.089825bc.akpm@osdl.org>
In-Reply-To: <20060810001115.525351000@linux-m68k.org>
References: <20060810000146.913645000@linux-m68k.org>
	<20060810001115.525351000@linux-m68k.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 02:01:54 +0200
zippel@linux-m68k.org wrote:

> This converts the kernel ntp model into a model which matches the
> nanokernel reference implementations.

For the ntp ignorami amongst us...  what is a "nanokernel reference
implementation" and why do we want one?

Thanks.
