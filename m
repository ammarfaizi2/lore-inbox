Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266774AbSLJWR3>; Tue, 10 Dec 2002 17:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbSLJWR3>; Tue, 10 Dec 2002 17:17:29 -0500
Received: from irongate.swansea.linux.org.uk ([194.168.151.19]:15041 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266774AbSLJWRY>; Tue, 10 Dec 2002 17:17:24 -0500
Subject: Re: HPT372 RAID controller
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Spacecake <lkml@spacecake.plus.com>
Cc: sflory@rackable.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021210180931.0b174cd5.lkml@spacecake.plus.com>
References: <20021208123134.4be342c7.lkml@spacecake.plus.com>
	<3DF4E433.5010207@rackable.com>
	<20021209203338.32e8665f.lkml@spacecake.plus.com>
	<1039480307.12051.8.camel@irongate.swansea.linux.org.uk> 
	<20021210180931.0b174cd5.lkml@spacecake.plus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 20:58:08 +0000
Message-Id: <1039553984.14302.65.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 18:09, Spacecake wrote:
> The .config for the kernel was identical to my 2.4.20 config that has
> never crashed, except it has IDE Taskfile IO enabled, because from the
> help this seemed like a good thing.

Does the same occur without taskfile I/O ?

