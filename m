Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266586AbSKZSIF>; Tue, 26 Nov 2002 13:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266585AbSKZSIF>; Tue, 26 Nov 2002 13:08:05 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:43154 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266586AbSKZSIE>; Tue, 26 Nov 2002 13:08:04 -0500
Subject: Re: A Kernel Configuration Tale of Woe
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dpaun@rogers.com
Cc: Rusty Lynch <rusty@linux.co.intel.com>, trog@wincom.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200211261304.32678.dpaun@rogers.com>
References: <3de395e1.2c79.0@wincom.net>
	<002001c29572$2ce2b2e0$94d40a0a@amr.corp.intel.com> 
	<200211261304.32678.dpaun@rogers.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Nov 2002 18:46:22 +0000
Message-Id: <1038336382.2594.67.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-26 at 18:04, Dimitrie O. Paun wrote:
> On November 26, 2002 12:35 pm, Rusty Lynch wrote:
> > So how would you deal with somebody contributing bogus mappings?
> > What if somebody was just wrong, or uploading a mapping in error?
> 
> The same applies to the kernel code, or any other open source project:
> How do you deal with somebody contributing bogus code?
> 
> Somehow things work out, as we have already witnessed.

For boards its not that simple. Many vendors release multiple utterly
different machines with the same box, bios and ident. The customer is
told "IDE CD, 100mbit ethernet", the customer gets random cheapest going
ethernet.

Alan

