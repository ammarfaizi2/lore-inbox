Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266794AbSKHQcN>; Fri, 8 Nov 2002 11:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbSKHQcN>; Fri, 8 Nov 2002 11:32:13 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:17820 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266794AbSKHQcM>; Fri, 8 Nov 2002 11:32:12 -0500
Subject: Re: [PATCH] [TRIVIAL] hda: DMA disabled
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Denis Zaitsev <zzz@cd-club.ru>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021108010121.A674@natasha.zzz.zzz>
References: <20021108010121.A674@natasha.zzz.zzz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Nov 2002 17:02:08 +0000
Message-Id: <1036774928.16651.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-07 at 20:01, Denis Zaitsev wrote:
> I have such a pessimistic messages at the startup, and nothing
> relaxing is following, keeping such a feeling that DMA is really
> disabled.  The tiny patch below brings the patiency, even though I'm
> not sure that this is the exact way.  So, please apply, if it's
> appropriate.

We are going to need more not less debug before 2.6. When its 2.6-rc
then yes its time to quieten down but not while the IDE is stil being
debugged

