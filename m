Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262904AbSJLL3C>; Sat, 12 Oct 2002 07:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262906AbSJLL3C>; Sat, 12 Oct 2002 07:29:02 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:15026 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262904AbSJLL3B>; Sat, 12 Oct 2002 07:29:01 -0400
Subject: Re: Linux v2.5.42
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jw schultz <jw@pegasys.ws>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021012111140.GA22536@pegasys.ws>
References: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com>
	<20021012095026.GC28537@merlin.emma.line.org> 
	<20021012111140.GA22536@pegasys.ws>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Oct 2002 12:46:37 +0100
Message-Id: <1034423197.14382.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-12 at 12:11, jw schultz wrote:
> So far everything indicates that LVM2 is not compatible with
> LVM.  That LVM2 and LVM(1) can coexist-exist is irrelevant if
> 2.5 hasn't got a working LVM(1).  And that would leave us
> with having to do backup+restore around the upgrade.

LVM2 supports LVM1 volumes. I don't know where you got the idea
otherwise. 

