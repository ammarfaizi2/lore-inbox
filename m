Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271360AbTGQI3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 04:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271362AbTGQI3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 04:29:44 -0400
Received: from kogut.o2.pl ([212.126.20.61]:35520 "EHLO kogut.o2.pl")
	by vger.kernel.org with ESMTP id S271360AbTGQI3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 04:29:42 -0400
Date: Thu, 17 Jul 2003 10:06:40 +0200
From: Rafal Bujnowski <bujnor@go2.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: "Paul Rolland" <rol@as2917.net>
Subject: Re: [BUG] kernel BUG at kernel/timer.c 2.6.0-test1
Message-Id: <20030717100640.0dd57630.bujnor@go2.pl>
In-Reply-To: <006e01c34b60$760ccd80$3f00a8c0@witbe>
References: <20030715102339.1ff31f77.bujnor@go2.pl>
	<006e01c34b60$760ccd80$3f00a8c0@witbe>
Organization: bujnor.lan
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Debian GNU/Linux 3.0
X-Registered-Linux-User: 203781
X-Website: http://www.bujnor.iq.pl/
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A "Paul Rolland" <rol@as2917.net> na to:

> Hello,
> 
> Are you using ide-scsi ? I though (from I got from the list some
> time ago) that it was not working with 2.5.x kernels, and that 
> we had to use ide-cd instead...

Hello,

Yes, I use ide-scsi. Ide-cd doesn't work for me. Even I tried to unset
"preemptible kernel" in config as was mentioned on lkml. But... still
nothing. 

So I have to use 2.4.20 instead of 2.6.x. 


Rafal



-- 

[              Rafal Bujnowski ][ e-mail: bujnor<at>go2.pl            ]
[     http://www.bujnor.iq.pl/ ][ e-mail: bujnor<at>poczta.onet.pl    ]
[   ICQ: 85602025  GG: 4174829 ][ Jabber: bujnor<at>jabberpl.org      ]
