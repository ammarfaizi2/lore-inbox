Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTJ0MiN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 07:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbTJ0MiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 07:38:13 -0500
Received: from mail.gmx.de ([213.165.64.20]:42703 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261684AbTJ0MiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 07:38:09 -0500
X-Authenticated: #2034091
Message-ID: <2523214.1067258282491.JavaMail.jpl@remotejava>
Date: Mon, 27 Oct 2003 13:38:02 +0100 (CET)
From: Jan Ploski <jpljpl@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-testX and pppd/pppoe stuck after connecting
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Borzenkov wrote:
> I can confirm it with 2.6.0-test8 and simple modem connection (no
> pppoe). Connection is established, I get IP, DNS - everything but no
> IP packet ever seems to either go out or come in. The same works just
> fine with 2.6.0-test5

Thanks to everyone who has replied.

I just wanted to remark that I had earlier the same problem with
2.6.0-test4, so it seems strange to me that 2.6.0-test5 would work ok.

I upgraded pppoe to 3.5 in hope that it would help, but that was
probably pointless given that the same problem occurs in pure dialup
context.

I can also offer help with diagnosing, but I feel that I would need some
even more detailed guidance than Andrev (preferably in form of patches,
as I have zero experience with kernel debugging).

Regards -
Jan Ploski

