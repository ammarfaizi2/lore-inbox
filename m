Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317512AbSG2QyR>; Mon, 29 Jul 2002 12:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSG2QyR>; Mon, 29 Jul 2002 12:54:17 -0400
Received: from dsl-65-188-226-101.telocity.com ([65.188.226.101]:21454 "EHLO
	crown.reflexsecurity.com") by vger.kernel.org with ESMTP
	id <S317512AbSG2QyR>; Mon, 29 Jul 2002 12:54:17 -0400
Date: Mon, 29 Jul 2002 12:57:33 -0400
From: Jason Lunz <lunz@reflexsecurity.com>
To: zhengchuanbo <zhengcb@netpower.com.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can the driver e100 be applied in 2.4?
Message-ID: <20020729165732.GA30314@reflexsecurity.com>
References: <200207291425517.SM00792@zhengcb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207291425517.SM00792@zhengcb>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In gmane.linux.kernel, you wrote:
> in linux2.5 there is a new driver e100 to replace eepro100. is e100
> better than eepro100 in performance such as throughput? and can the
> driver e100 be applied in 2.4?

There's a patch to put the e100 driver in 2.4 at
http://gtf.org/lunz/linux/net/. There is currently no NAPI support for
that driver.

-- 
Jason Lunz			Reflex Security
lunz@reflexsecurity.com		http://www.reflexsecurity.com/
