Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317454AbSGOMQM>; Mon, 15 Jul 2002 08:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317457AbSGOMQL>; Mon, 15 Jul 2002 08:16:11 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:23800 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317454AbSGOMQK>; Mon, 15 Jul 2002 08:16:10 -0400
Subject: Re: Status of DRI modules for i810 with > 2.4.19-pre6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steve Kieu <haiquy@yahoo.com>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020715065706.7276.qmail@web10403.mail.yahoo.com>
References: <20020715065706.7276.qmail@web10403.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Jul 2002 14:28:54 +0100
Message-Id: <1026739734.13885.120.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-15 at 07:57, Steve Kieu wrote:
> I am forced to upgrade to XFree86-4.2.0 :-) but
> happily to say the problem is gone with and without
> preemptible patch.
> 
> So it is rather a bug in XFree86 < 4.2.0 ?

There are DRI problems with i810 older XFree86, with the kernel AGP code
and with the kernel DRI code. All three of which have at some point been
tackled. My i810 is looking pretty solid at the moment but I've got some
3D funnies to look into

