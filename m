Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbVJKQum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbVJKQum (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 12:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbVJKQul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 12:50:41 -0400
Received: from seqima.han-solo.net ([83.138.65.243]:56792 "EHLO
	seqima.han-solo.net") by vger.kernel.org with ESMTP
	id S1751446AbVJKQul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 12:50:41 -0400
Message-ID: <434BED55.10603@gmx.de>
Date: Tue, 11 Oct 2005 18:50:29 +0200
From: Georg Lippold <georg.lippold@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] 2.6.14-rc3 x86: COMMAND_LINE_SIZE
References: <431628D5.1040709@zytor.com> <4345A9F4.7040000@uni-bremen.de>	 <434A6220.3000608@gmx.de>	 <9a8748490510100621x7bc20c42g667cc083d26aaaa2@mail.gmail.com>	 <434A8082.9060202@zytor.com> <434A8CE8.2020404@gmx.de>	 <434A8D70.5060300@zytor.com>	 <20051010171605.GA7793@georg.homeunix.org>	 <434AB1EB.6070309@gmail.com> <434AD0EB.6000405@gmx.de> <9e0cf0bf0510110132y64c5b42dsb2211d4e75d06f15@mail.gmail.com>
In-Reply-To: <9e0cf0bf0510110132y64c5b42dsb2211d4e75d06f15@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:
> But the address of cmd_line_ptr is defined to be from the end of the
> setup to 0xa0000. This is well defined, since the boot loader will
> load the kernel, initramfs and cmd_line_ptr to the correct place...
> Nothing is overwritten... Then the kernel is up and takes as much as
> it needs from cmd_line_ptr.

OK, then: Update my patch if you want to and resubmit it. I would like
to get this through as quickly as possible.

Greetings,

Georg
