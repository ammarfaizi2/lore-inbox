Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbTJ1Vl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 16:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbTJ1Vl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 16:41:26 -0500
Received: from mail.gmx.de ([213.165.64.20]:64476 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261546AbTJ1VlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 16:41:25 -0500
X-Authenticated: #2034091
Message-ID: <2523214.1067375685145.JavaMail.jpl@remotejava>
Date: Tue, 28 Oct 2003 22:14:44 +0100 (CET)
From: Jan Ploski <jpljpl@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-testX and pppd/pppoe stuck after connecting
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Borzenkov wrote:
>>> I can confirm it with 2.6.0-test8 and simple modem connection (no
>>> pppoe). Connection is established, I get IP, DNS - everything but no
>>> IP packet ever seems to either go out or come in. The same works just
>>> fine with 2.6.0-test5
>
> whatever evil it was it has apparently disappeared in test9. Which may be
> good or bad news for you depending on whether your problem is fixed here
> as well.

Unfortunately, nothing has changed for me with test9 - I just had my
ppp0 "stuck" in the very same manner as before. Still hoping for some
bits of advice from experts here...

Best regards -
Jan Ploski

