Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264632AbRGELSy>; Thu, 5 Jul 2001 07:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264652AbRGELSn>; Thu, 5 Jul 2001 07:18:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51974 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264632AbRGELSa>; Thu, 5 Jul 2001 07:18:30 -0400
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
To: dmircea@kappa.ro (Mircea Damian)
Date: Thu, 5 Jul 2001 12:18:46 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20010705104650.A2820@linux.kappa.ro> from "Mircea Damian" at Jul 05, 2001 10:46:50 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15I79i-0002NI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This bug hits me since 2.4.6-pre5 but nobody answered to my emails... The
> code line is identical (and the softirq.c:206 ofc).
> 
> Anyone, any idea?

None at all. There are odd items in your config - like khttpd which if 
involved might explain why there are not more reports.



