Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318790AbSHLSyH>; Mon, 12 Aug 2002 14:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318791AbSHLSyH>; Mon, 12 Aug 2002 14:54:07 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:48367 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318790AbSHLSyG>; Mon, 12 Aug 2002 14:54:06 -0400
Subject: Re: 2.4.19 and 2.4.20-pre1 don't boot
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Klotz <peter.klotz@aon.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000501c24230$8a29bdd0$8c00000a@sledgehammer>
References: <000501c24230$8a29bdd0$8c00000a@sledgehammer>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Aug 2002 19:55:14 +0100
Message-Id: <1029178514.16424.205.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-12 at 19:46, Peter Klotz wrote:
> Hi
> 
> Up to 2.4.19-rc1 my system worked fine but 2.4.19 and 2.4.20-pre1 produce
> the following message at startup:
> 
> Mounting root filesystem
> ide-floppy driver 0.99.newide
> kmod: failed to exec /sbin/modprobe -s -k ide-cd, errno = 2
> hda: driver not present

Compile in hard disk support

