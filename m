Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281662AbRKQAnd>; Fri, 16 Nov 2001 19:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281647AbRKQAnY>; Fri, 16 Nov 2001 19:43:24 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:19142 "EHLO
	c0mailgw10.prontomail.com") by vger.kernel.org with ESMTP
	id <S281662AbRKQAnN>; Fri, 16 Nov 2001 19:43:13 -0500
Message-ID: <3BF5B275.215D6D44@starband.net>
Date: Fri, 16 Nov 2001 19:42:29 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Swap Usage with Kernel 2.4.14
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regular usage on my box, launching netscape, opera, pan, xchat, gaim;
the kernel eventually digs into swap.

However, the swap is never released?

Mem:   900596K av,  185896K used,  714700K free,       0K shrd,    4172K
buff
Swap: 2048276K av,   63728K used, 1984548K free                   91176K
cached

Are there any settings I should have set or be aware of?

I current use 4GB support, 1GB of ram, 2GB of swap.

Having 1GB, I thought I had enough memory for basic operations without
the disk swapping like mad.

