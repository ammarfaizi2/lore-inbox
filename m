Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSG3VGU>; Tue, 30 Jul 2002 17:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSG3VGT>; Tue, 30 Jul 2002 17:06:19 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:10995 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316569AbSG3VGT>; Tue, 30 Jul 2002 17:06:19 -0400
Subject: Re: [PATCH] 2.5.29: some compilation fixes for irq frenzy [OSS +
	i8x0 audio]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andy Pfiffer <andyp@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1028062608.964.6.camel@andyp>
References: <1028062608.964.6.camel@andyp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 Jul 2002 23:25:51 +0100
Message-Id: <1028067951.8510.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-30 at 21:56, Andy Pfiffer wrote:
> This patch cleans up the save_flags()/cli() craziness in the OSS portion
> of the i8x0 audio driver.
> 
> Apply to ChangeSet 1.524
> 
> Built, booted, and played some tunes.

But not it appears on an SMP system

