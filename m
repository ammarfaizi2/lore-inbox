Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266115AbSKTNbu>; Wed, 20 Nov 2002 08:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266116AbSKTNbu>; Wed, 20 Nov 2002 08:31:50 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:13441 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266115AbSKTNbt>; Wed, 20 Nov 2002 08:31:49 -0500
Subject: Re: [PATCH] Allow 2.5.48 IDE to compile w/o DMA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Phil Oester <kernel@theoesters.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021119210115.A32262@ns1.theoesters.com>
References: <20021119210115.A32262@ns1.theoesters.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 14:07:22 +0000
Message-Id: <1037801242.3267.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 05:01, Phil Oester wrote:
> Attempting to compile 2.5.48-bk with generic IDE support, but not DMA support gives the following errors:

This is already fixed up differently in 2.5.47-ac. If 2.5.49 works well
enough to test I'll submit the IDE updates then


Alan
