Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbSKVNBa>; Fri, 22 Nov 2002 08:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264714AbSKVNB3>; Fri, 22 Nov 2002 08:01:29 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:22924 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264610AbSKVNB3>; Fri, 22 Nov 2002 08:01:29 -0500
Subject: Re: [RFC] [PATCH] subarch-cleanup_A1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: john stultz <johnstul@us.ibm.com>
Cc: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Russell King <rmk@arm.linux.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1037929596.7576.78.camel@w-jstultz2.beaverton.ibm.com>
References: <1037929596.7576.78.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Nov 2002 13:37:39 +0000
Message-Id: <1037972259.11846.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-22 at 01:46, john stultz wrote:
> Ok, next pass. How about this: (complete patch bz'ed and attached)

For the -ac tree I created a seperate mach/default so we can distinguish
"generic PC" from "default values"

