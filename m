Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136532AbREDWKe>; Fri, 4 May 2001 18:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136534AbREDWKY>; Fri, 4 May 2001 18:10:24 -0400
Received: from nwcst280.netaddress.usa.net ([204.68.23.25]:59558 "HELO
	nwcst280.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S136532AbREDWKJ> convert rfc822-to-8bit; Fri, 4 May 2001 18:10:09 -0400
Message-ID: <20010504221007.29155.qmail@nwcst280.netaddress.usa.net>
Date: 4 May 2001 17:10:07 CDT
From: shreenivasa H V <shreenihv@usa.net>
To: linux-kernel@vger.kernel.org
Subject: TCP Timer granularity
X-MSMail-Priority: High
X-Priority: 1
X-Mailer: USANET web-mailer (34FM.0700.17C.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can anyone tell me what is the granularity of the TCP timer in kernel 2.4? Can
I have microsecond timers? What's the value I need to use for the field
"tcp_opt.timer.expires" if I need to have something like 20 ms timer?

shreeni.

____________________________________________________________________
Get free email and a permanent address at http://www.netaddress.com/?N=1
