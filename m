Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSHFWg7>; Tue, 6 Aug 2002 18:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSHFWg7>; Tue, 6 Aug 2002 18:36:59 -0400
Received: from host.greatconnect.com ([209.239.40.135]:45833 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S316089AbSHFWg6>; Tue, 6 Aug 2002 18:36:58 -0400
Subject: Re: OSB4 issues on 2.4.19-ac4
From: Samuel Flory <sflory@rackable.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1028671263.18130.194.camel@irongate.swansea.linux.org.uk>
References: <1028660121.4771.1242.camel@flory.corp.rackablelabs.com> 
	<1028671263.18130.194.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Aug 2002 15:39:43 -0700
Message-Id: <1028673603.4771.1270.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Manually via hdparm.  The driver leaves it off.

On Tue, 2002-08-06 at 15:01, Alan Cox wrote:
> On Tue, 2002-08-06 at 19:55, Samuel Flory wrote:
> >   It appears that the OSB4 ide controller isn't working on ac4.  I have
> > a Tyan 2515, and 2518 which hang when dma is enabled.
> 
> DMA enabled by you or by the driver. Right now the driver isnt supposed
> to be enabling DMA on OSB4
> 


