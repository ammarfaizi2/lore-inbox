Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263151AbSJGQFa>; Mon, 7 Oct 2002 12:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263160AbSJGQFa>; Mon, 7 Oct 2002 12:05:30 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:48368 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263151AbSJGQF2>; Mon, 7 Oct 2002 12:05:28 -0400
Subject: Re: 2.5.40: more fun with intel se7500wv2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jure Pecar <Jure.Pecar@select-tech.si>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210071603.g97G3c226136@stsrv.select-tech.si>
References: <200210071603.g97G3c226136@stsrv.select-tech.si>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Oct 2002 17:20:46 +0100
Message-Id: <1034007646.25101.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-07 at 17:03, Jure Pecar wrote:
> On Mon, 7 Oct 2002 17:40:49 +0200
> Jure Pecar <jure.pecar@select-tech.si> wrote:
> 
> > All dmesgs stop at scsi, which is already
> > being looked at. 
> 
> Ok, Justin Gibbs just told me that this is an interrupt routing problem
> and not a driver problem. Who can i ask more about that?
> I'm really eager to have this box running properly with 2.5 kernel.

You might want to try changing the ACPI settings and using ACPI for your
IRQ routing.

