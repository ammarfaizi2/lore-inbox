Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315760AbSHFUiV>; Tue, 6 Aug 2002 16:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSHFUiV>; Tue, 6 Aug 2002 16:38:21 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:24308 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315760AbSHFUiT>; Tue, 6 Aug 2002 16:38:19 -0400
Subject: Re: OSB4 issues on 2.4.19-ac4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Samuel Flory <sflory@rackable.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1028660121.4771.1242.camel@flory.corp.rackablelabs.com>
References: <1028660121.4771.1242.camel@flory.corp.rackablelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Aug 2002 23:01:03 +0100
Message-Id: <1028671263.18130.194.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-06 at 19:55, Samuel Flory wrote:
>   It appears that the OSB4 ide controller isn't working on ac4.  I have
> a Tyan 2515, and 2518 which hang when dma is enabled.

DMA enabled by you or by the driver. Right now the driver isnt supposed
to be enabling DMA on OSB4

