Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264058AbRFERZH>; Tue, 5 Jun 2001 13:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264057AbRFERY5>; Tue, 5 Jun 2001 13:24:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38916 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264054AbRFERYk>; Tue, 5 Jun 2001 13:24:40 -0400
Subject: Re: IRQ conflicts
To: user753@yahoo.com (753 user)
Date: Tue, 5 Jun 2001 18:22:59 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010605125244.32650.qmail@web14706.mail.yahoo.com> from "753 user" at Jun 05, 2001 05:52:44 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E157KXj-000780-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >With 2.4.5 I *often* get kernel Oopses with IRQ
> >routing error messages. This never happend before
> >and the only one change was a a second network
> >card inserted into the mobo and changed kernel
> >from 2.4.3 to 2.4.5.
> 
> As as wrote... Here is one of them, getting every 3
> hours...

See REPORTING-BUGS and include the call trace details and ksymoops data
