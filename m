Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTENQEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTENQEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:04:13 -0400
Received: from kogut2.o2.pl ([212.126.20.58]:7053 "EHLO kogut2.o2.pl")
	by vger.kernel.org with ESMTP id S262601AbTENQEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:04:11 -0400
Date: Wed, 14 May 2003 18:06:10 +0200
From: Rafal Bujnowski <bujnor@go2.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Subject: Re: hdb: dma_timer_expiry: dma status == 0x64 [2.5.69]
Message-Id: <20030514180610.13ffd2dd.bujnor@go2.pl>
In-Reply-To: <Pine.LNX.4.51.0305141611130.22227@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0305132143570.19932@dns.toxicfilms.tv>
	<20030514134704.GA1062@babylon.d2dc.net>
	<Pine.LNX.4.51.0305141611130.22227@dns.toxicfilms.tv>
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

A Maciej Soltysiak <solt@dns.toxicfilms.tv> na to:

> Exactly like me.
> Someone suggested Bartlomiej Zolnierkiewicz's patch.
> Try this on for size. I haven't tested it yet, but please give it a
> shot.

Hello!

It doesn't work. I still get:

hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }

I'll try Dany's hint.

rafal


-- 

[              Rafal Bujnowski ][ e-mail: bujnor<at>go2.pl            ]
[     http://www.bujnor.iq.pl/ ][ e-mail: bujnor<at>poczta.onet.pl    ]
[   ICQ: 85602025  GG: 4174829 ][ Jabber: bujnor@jabber.org           ]
