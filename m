Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262139AbSJZNnZ>; Sat, 26 Oct 2002 09:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262145AbSJZNnZ>; Sat, 26 Oct 2002 09:43:25 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:50378 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262139AbSJZNnY>; Sat, 26 Oct 2002 09:43:24 -0400
Subject: Re: KT333, IO-APIC, Promise Fasttrak, Initrd
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: freaky <freaky@bananateam.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <001401c27cbc$53ecf810$1400a8c0@Freaky>
References: <007501c27c5d$378aef10$1400a8c0@Freaky><1035580299.13244.82.camel@irongate.s
	 wansea.linux.org.uk> <000c01c27c6a$fe2e9b00$1400a8c0@Freaky>
	<1035582704.12995.91.camel@irongate.swansea.linux.org.uk> 
	<001401c27cbc$53ecf810$1400a8c0@Freaky>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Oct 2002 15:06:31 +0100
Message-Id: <1035641191.13244.108.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-26 at 07:53, freaky wrote:
> So that would be data on the MBR, or partition table? Perhaps win doesn't
> have probs because it can handle to partitions types properly. MSI told me

No its seperate. The hpt/promise raid "borrows" part of the disk and
hides it.
