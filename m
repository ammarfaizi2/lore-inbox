Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261608AbSJYV24>; Fri, 25 Oct 2002 17:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261612AbSJYV24>; Fri, 25 Oct 2002 17:28:56 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:41415 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261609AbSJYV2z>; Fri, 25 Oct 2002 17:28:55 -0400
Subject: Re: KT333, IO-APIC, Promise Fasttrak, Initrd
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: freaky <freaky@bananateam.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <000c01c27c6a$fe2e9b00$1400a8c0@Freaky>
References: <007501c27c5d$378aef10$1400a8c0@Freaky>
	<1035580299.13244.82.camel@irongate.swansea.linux.org.uk> 
	<000c01c27c6a$fe2e9b00$1400a8c0@Freaky>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 22:51:44 +0100
Message-Id: <1035582704.12995.91.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 22:10, freaky wrote:
> No problems under XP so far...what kind of blocks would that be? Only had
> time-outs on one of the disks when it was only slave (no master present
> forgot to attach it :/) but since the master is attached that's gone.... all
> my old data plays fine, mainly mp3's, games and movies.

The HPT and Promise raid cards add extra partition table type data of
their own identifying each volume. Their drivers then read and honour
that info.

> I'll supply all of the info later, low on time now and it's late. Want the
> kernel config and such as well? BIOS setup?

If it looks useful include it 8)

