Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271657AbTGRAYN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 20:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271659AbTGRAYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 20:24:13 -0400
Received: from CPE-144-137-15-28.vic.bigpond.net.au ([144.137.15.28]:44259
	"EHLO lnk.wurley.net") by vger.kernel.org with ESMTP
	id S271657AbTGRAYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 20:24:00 -0400
From: "Deon George" <kernel@wurley.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Eran Mann <emann@mrv.com>, linux-kernel@vger.kernel.org
Subject: Re: please help - kernel OOPS
Date: Fri, 18 Jul 2003 10:38:38 +1000
Message-Id: <20030718003838.M79515@wurley.net>
In-Reply-To: <1058395864.7678.5.camel@dhcp22.swansea.linux.org.uk>
References: <20030716120856.M31641@wurley.net> <1058368734.6633.21.camel@dhcp22.swansea.linux.org.uk> <20030716223431.M85416@wurley.net> <1058395864.7678.5.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Open WebMail 1.81 20021127
X-OriginatingIP: 202.81.18.30 (deon)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan/Eran,

Thanks for your TIPS - I'm thinking that it is the memory being the problem.

I download and run memtest86 v3 and I have many errors (25-35) when it run test #3 
and test #4 (I'm just memtest86 without any configuration).

Given that this is the 2nd (different) type of memory Ive tried - I'll get my 
supplier to give me something else and hopefully that'll fix the Ooopss..

Thanks for your tips!

...deon

On 16 Jul 2003 23:51:04 +0100, Alan Cox wrote
> On Mer, 2003-07-16 at 23:34, Deon George wrote:
> > G'day Alan,
> > 
> > I was wondering if it was a memory issue.
> 
> memtest86 should help find this out, as should going into the BIOS and
> setting "safe settings" then seeing if its stable.
> 
> > Who makes the the memory that you are using? (I guess you have problems with 
the 
> > V8000 too right?)
> 
> I'm using micron RAM I think.
> 
> > > Are you within power budget for your system if its a tiny little PSU
> > > brick ?
> > 
> > Are you thinking that the power supply could be the cause of the problem?
> 
> I don't know but you mention it occurs when the disks are very active - 
> that could be DMA/RAM loading or power



...deon
Wurley Solutions
---
 _--_|\   | Deon George
/      \  | 
\_.--.*/  | 
      v   | This email coming to you from the 'burbs of Melbourne,
Australia.

