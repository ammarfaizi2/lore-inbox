Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267832AbUHKAM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267832AbUHKAM6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 20:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267836AbUHKAM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 20:12:57 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:2551 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267832AbUHKAM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 20:12:56 -0400
Date: Tue, 10 Aug 2004 20:12:55 -0400
From: Tom Vier <tmv@comcast.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1
Message-ID: <20040811001255.GA14402@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <20040810002110.4fd8de07.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810002110.4fd8de07.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/i2c/busses/i2c-keywest.c: In function `__check_probe':
drivers/i2c/busses/i2c-keywest.c:94: error: `probe' undeclared (first use in this function)
drivers/i2c/busses/i2c-keywest.c:94: error: (Each undeclared identifier is reported only once
drivers/i2c/busses/i2c-keywest.c:94: error: for each function it appears in.)
drivers/i2c/busses/i2c-keywest.c: At top level:
drivers/i2c/busses/i2c-keywest.c:94: error: `probe' undeclared here (not in a function)
drivers/i2c/busses/i2c-keywest.c:94: error: initializer element is not constant
drivers/i2c/busses/i2c-keywest.c:94: error: (near initialization for `__param_probe.arg')
drivers/i2c/busses/i2c-keywest.c:96: error: `probe' used prior to declaration
make[3]: *** [drivers/i2c/busses/i2c-keywest.o] Error 1
make[2]: *** [drivers/i2c/busses] Error 2
make[1]: *** [drivers/i2c] Error 2
make: *** [drivers] Error 2

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
