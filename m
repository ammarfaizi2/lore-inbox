Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319377AbSIFU0D>; Fri, 6 Sep 2002 16:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319378AbSIFU0D>; Fri, 6 Sep 2002 16:26:03 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:8950 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319377AbSIFU0C>; Fri, 6 Sep 2002 16:26:02 -0400
Subject: Re: ide drive dying?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mbs <mbs@mc.com>
Cc: DevilKin <devilkin-lkml@blindguardian.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200209061742.NAA20207@mc.com>
References: <200209061713.51387.devilkin-lkml@blindguardian.org> 
	<200209061742.NAA20207@mc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 06 Sep 2002 21:32:08 +0100
Message-Id: <1031344328.10612.83.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-06 at 18:46, mbs wrote:
> fdisk/format and reinstall but stick with a 2.4.19 or 2.4.19-ac kernel.
> 
> I would bet money that the problem is purely a .20-preX-acX thing.

Its a status entry direct from the drive. The drive says "uncorrectable
error" which means there is a media problem. Its nothing to do with
Linux

