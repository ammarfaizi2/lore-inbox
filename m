Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266560AbSKZT2f>; Tue, 26 Nov 2002 14:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbSKZT1U>; Tue, 26 Nov 2002 14:27:20 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:30611 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266615AbSKZT1L>; Tue, 26 Nov 2002 14:27:11 -0500
Subject: Re: A Kernel Configuration Tale of Woe
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: trog@wincom.net
Cc: dpaun@rogers.com, Rusty Lynch <rusty@linux.co.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3de3cc8d.54dd.0@wincom.net>
References: <3de3cc8d.54dd.0@wincom.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Nov 2002 20:05:31 +0000
Message-Id: <1038341131.2534.73.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-26 at 19:28, Dennis Grant wrote:
> Agreed - so then the association between "board" and "chipset" must be capable
> of being multi-valued, and when there is a mult-valued match there must be some
> means of further interrogating the user (or user agent) for more information.

Much simpler to just include "modular everything" and let user space
sort it out. Guess why every vendor takes this path

