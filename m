Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271672AbRHQPUr>; Fri, 17 Aug 2001 11:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271675AbRHQPUh>; Fri, 17 Aug 2001 11:20:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50190 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271673AbRHQPUa>; Fri, 17 Aug 2001 11:20:30 -0400
Subject: Re: Kernel panic problem in 2.4.7
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 17 Aug 2001 16:23:16 +0100 (BST)
Cc: antihong@tt.co.kr (=?ks_c_5601-1987?B?v8C0w7D6s7vAzyDIq7yuufw=?=),
        linux-kernel@vger.kernel.org
In-Reply-To: <E15XlHk-0007Uy-00@the-village.bc.nu> from "Alan Cox" at Aug 17, 2001 04:11:44 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15XlSu-0007Wr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If your cpu context corrupt is with a machine check exception report then
> your processor took an internal fault reporting trap. So its not a happy
> bit of silicon I suspect - be it overclocked, overheated, or even faulty.

Beware beta versions of editors 8)

If your CPU context corrupt message is appearing with a machine check
exception report, then you processor took an internal fault reporting trap.

So it's not a happy piece of silicon I suspect - be it overclocked,
overheated or even faulty.

The machine check numbers it prints can be looked up in the processor
manuals to decode the type of fault.
