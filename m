Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285552AbRLYNOz>; Tue, 25 Dec 2001 08:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285540AbRLYNOp>; Tue, 25 Dec 2001 08:14:45 -0500
Received: from web20306.mail.yahoo.com ([216.136.226.87]:7687 "HELO
	web20306.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S285532AbRLYNOm>; Tue, 25 Dec 2001 08:14:42 -0500
Message-ID: <20011225131441.60811.qmail@web20306.mail.yahoo.com>
Date: Tue, 25 Dec 2001 05:14:41 -0800 (PST)
From: Amber Palekar <amber_palekar@yahoo.com>
Subject: Again:syscall from modules
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <shssn9zv43k.fsf@charged.uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi,
 
> Just use sock_sendmsg() and sock_recvmsg() directly.
> They are both
> exported in netsyms.c.
  Is there any specific reason behind not exporting
sys_sendto and sys_recvfrom ??

> Cheers,
>   Trond

TIA
Amber


__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com
