Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317152AbSFFS5G>; Thu, 6 Jun 2002 14:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317141AbSFFSzb>; Thu, 6 Jun 2002 14:55:31 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:6650 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317142AbSFFSyk>; Thu, 6 Jun 2002 14:54:40 -0400
Subject: Re: PDC20267 + RAID can't find raid device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Thompson <wt@electro-mechanical.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020606111918.F7291@coredump.electro-mechanical.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Jun 2002 20:47:34 +0100
Message-Id: <1023392854.23013.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-06 at 16:19, William Thompson wrote:
> After trying 2.4.19-pre10-ac2 I can finally use the PDC20267 controller,
> however, it doesn't find any raid devices.

Great. One success to Hank at promise.

> 
> I have 2 quantum fireballlct10 05 on the controller (hde and hdg) and
> created a stripe between these 2 disks in the controller's bios
> I can see both disks w/o problems.

Do you have the ataraid driver loaded - what did it report ?


