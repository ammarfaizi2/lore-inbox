Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130721AbRCZI5d>; Mon, 26 Mar 2001 03:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131884AbRCZI5W>; Mon, 26 Mar 2001 03:57:22 -0500
Received: from web3405.mail.yahoo.com ([204.71.203.59]:8710 "HELO
	web3405.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130721AbRCZI5M>; Mon, 26 Mar 2001 03:57:12 -0500
Message-ID: <20010326085631.12275.qmail@web3405.mail.yahoo.com>
Date: Mon, 26 Mar 2001 10:56:31 +0200 (CEST)
From: Marc x <marcj59@yahoo.fr>
Subject: IRQ timeout when switching slot on ide cdrom changer
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have this problem on kernel 2.4.2, various ac
patches, including latest ac24.

When requesting a slot change, most of the time I get
a 
>hdc: irq timeout: status=0xd0 { Busy } 
>hdc: ATAPI reset complete 

and the drive switches me back to the first slot. 
I have tried w/ an w/o DMA , no succes.

The same drive worked fine under various 2.2.x
kernels.

Marc.


___________________________________________________________
Do You Yahoo!? -- Pour dialoguer en direct avec vos amis, 
Yahoo! Messenger : http://fr.messenger.yahoo.com
