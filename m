Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319142AbSIDLcg>; Wed, 4 Sep 2002 07:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319144AbSIDLcg>; Wed, 4 Sep 2002 07:32:36 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:54515
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319142AbSIDLcg>; Wed, 4 Sep 2002 07:32:36 -0400
Subject: Re: P4 with i845E not booting with 2.4.19 / 3.5.31
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Wiesecke <j_wiese@hrzpub.tu-darmstadt.de>
Cc: Justin Heesemann <jh@ionium.org>, linux-kernel@vger.kernel.org,
       tspinillo@yahoo.com
In-Reply-To: <3D75B0A1.3070707@hrzpub.tu-darmstadt.de>
References: <200209030153.47433.jh@ionium.org> 
	<3D75B0A1.3070707@hrzpub.tu-darmstadt.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 04 Sep 2002 12:36:34 +0100
Message-Id: <1031139394.3017.61.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-04 at 08:05, Jens Wiesecke wrote:
> so the problem seems to be BIOS related. But what I don't understand is 
> that since I tell the kernel to use 512 MByte of RAM (mem=512M) and 
> kernels up to 2.4.19pre6 can handle this:
> 
> What changed and is there a workaround for kernels newer than 2.4.19pre6 
> (for example telling the kernel not to rely on the memory information of 
> the BIOS e820 procedure) ?
> 
> I tried to compile 2.4.20pre5-(ac) with the arch/i386/kernel/setup.c 
> from 2.4.19pre6 but that didn't work.

I don't know. Without a serial console oops dump I don't have time to
figure it out either

