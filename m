Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319273AbSIKSk7>; Wed, 11 Sep 2002 14:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319274AbSIKSk7>; Wed, 11 Sep 2002 14:40:59 -0400
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:62865 "EHLO
	rrzs2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S319273AbSIKSk5>; Wed, 11 Sep 2002 14:40:57 -0400
Date: Wed, 11 Sep 2002 20:45:00 +0200
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
To: Austin Gonyou <austin@coremetrics.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.4.20pre5aa2
Message-ID: <20020911204500.E13655@pc9391.uni-regensburg.de>
References: <20020911202801.C13655@pc9391.uni-regensburg.de> <1031769317.24629.28.camel@UberGeek.coremetrics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1031769317.24629.28.camel@UberGeek.coremetrics.com>; from austin@coremetrics.com on Mit, Sep 11, 2002 at 20:35:18 +0200
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11 Sep 2002 20:35:18 schrieb(en) Austin Gonyou:
> Ahh..I see now. So, before the machine reboots, what do you get in
> dmesg?
> 
> Anything, an oops maybe? maybe do dmesg > ~/somefile so you can keep
> them around after the reboot?
> 
> 

Have to correct my first statement. The Machine crashes in both cases, HT 
enabled or not...
But I didn't find any Output in dmesg.

I'll now try Andrea's patches...

thank you :)
Christian

