Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318772AbSHGReX>; Wed, 7 Aug 2002 13:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318775AbSHGReX>; Wed, 7 Aug 2002 13:34:23 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35323 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318772AbSHGReX>; Wed, 7 Aug 2002 13:34:23 -0400
Subject: Re: Oopses on dual Athlon with 2.4.19-ac4 and 2.4.20-pre1-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020807162932.GH23816@os.inf.tu-dresden.de>
References: <20020807162932.GH23816@os.inf.tu-dresden.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 19:57:03 +0100
Message-Id: <1028746623.18156.328.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 17:29, Adam Lackorzynski wrote:
> Hi,
> 
> I have a dual Athlon here which ooopses after 2 minutes of dnetc when
> running 2.4.19-ac4 or 2.4.20-pre1-ac1. I cannot reproduce this with
> 2.4.19 or 2.4.20-pre1. The two Athlons are sitting on a A7M266-D.

Are you loading the amd76x_pm module for power management ?

