Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317668AbSGaDIV>; Tue, 30 Jul 2002 23:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317672AbSGaDIV>; Tue, 30 Jul 2002 23:08:21 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:48141 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317668AbSGaDIV>; Tue, 30 Jul 2002 23:08:21 -0400
Date: Tue, 30 Jul 2002 23:05:58 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: zhengchuanbo <zhengcb@netpower.com.cn>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: can the driver e100 be applied in 2.4?
In-Reply-To: <200207291425517.SM00792@zhengcb>
Message-ID: <Pine.LNX.3.96.1020730230310.6974D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2002, zhengchuanbo wrote:

> 
> in linux2.5 there is a new driver e100 to replace eepro100. is e100 better than eepro100 in performance such as throughput? and can the driver e100 be applied in 2.4?
> please cc. thanks.

You should be able to pull the code from Intel and compile it for your 2.4
kernel. I have done that, and it was so free of tricks all I remember is
the compile and 'make install.' I have not tried the 2.5 code, I got the
Intel source.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

