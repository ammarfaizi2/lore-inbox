Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317604AbSHCQjZ>; Sat, 3 Aug 2002 12:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317606AbSHCQjZ>; Sat, 3 Aug 2002 12:39:25 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:10994 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317604AbSHCQjZ>; Sat, 3 Aug 2002 12:39:25 -0400
Subject: Re: 2.4.19 IDE Partition Check issue
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: alien.ant@ntlworld.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020803163708.GHUY23840.mta03-svc.ntlworld.com@[10.137.100.63]>
References: <20020803163708.GHUY23840.mta03-svc.ntlworld.com@[10.137.100.63]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 03 Aug 2002 19:00:50 +0100
Message-Id: <1028397650.1760.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-03 at 17:37, alien.ant@ntlworld.com wrote:
> Hi,
> 
> I attempted to upgrade from 2.4.18 to 2.4.19 today but one of machines repeatedly hangs at the "Partition check" on the IDE drives.
> 
> The machine is a Compaq Proliant 800 Pentium III SMP box with a Highpoint 370 IDE controller. I attempted several reboots with the check continually failing. Rebooting back to 2.4.18 removed the problem.
> 
> Searching the archive I note several other people have had this problem with 2.4.19-pre kernels but, as yet, there seems to be no resolution?
>
Can you try 2.4.19-ac1 once I upload it. That has slightly further
updated IDE code and it would useful to know if the same problem occurs

