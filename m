Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318016AbSHZJrl>; Mon, 26 Aug 2002 05:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318017AbSHZJrl>; Mon, 26 Aug 2002 05:47:41 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:3323 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318016AbSHZJrk>; Mon, 26 Aug 2002 05:47:40 -0400
Subject: Re: ATA err with 2.4.20-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Grega Fajdiga <Gregor.Fajdiga@telemach.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020826103525.7817bb4e.Gregor.Fajdiga@telemach.net>
References: <20020826103525.7817bb4e.Gregor.Fajdiga@telemach.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 26 Aug 2002 10:53:50 +0100
Message-Id: <1030355630.16767.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 09:35, Grega Fajdiga wrote:
> Good day,
> 
> I get these errors with 2.4.20-ac1:
> 
> hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hdb: task_no_data_intr: error=0x04 { DriveStatusError }

If people report IDE stuff I need to know the context, dmesg, controller
and drives. 


