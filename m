Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWBXNno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWBXNno (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 08:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWBXNno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 08:43:44 -0500
Received: from mail.21torr.com ([213.143.192.7]:2066 "EHLO mail.21torr.com")
	by vger.kernel.org with ESMTP id S1750919AbWBXNnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 08:43:43 -0500
Date: Fri, 24 Feb 2006 14:43:42 +0100
From: Florian Engelhardt <f.engelhardt@21torr.com>
To: Holger Eitzenberger <holger@my-eitzenberger.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel assertion in net/ipv4/tcp.c
Message-ID: <20060224144342.186243cc@HAL2000>
In-Reply-To: <20060224095350.GA5111@kruemel.my-eitzenberger.de>
References: <20060123102805.6bd39bcc@HAL2000>
	<20060224095350.GA5111@kruemel.my-eitzenberger.de>
Organization: 21TORR AGENCY
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006 10:53:50 +0100
Holger Eitzenberger <holger@my-eitzenberger.de> wrote:

> On Mon, Jan 23, 2006 at 10:28:05AM +0100, Florian Engelhardt wrote:
> 
> > Linux www 2.6.14-gentoo-r2 #4 SMP Mon Nov 28 10:35:23 CET 2005 i686
> > Intel(R) Xeon(TM) CPU 3.20GHz GenuineIntel GNU/Linux
> > 
> > I have a Marvell Yukon Ethernet card inside.
> > 
> > And i have some trouble with it (see the attached log file).
> > I get tons of error messages in my kern.log, all the same:
> > Jan 15 11:11:20 www kernel: KERNEL: assertion (flags & MSG_PEEK)
> > failed at net/ipv4/tcp.c (1171)
> 
> Hi,
> 
> I see similar errors here on several boxes, all with Marvel chipsets
> and sk98lin.  Do you use sk98lin or skge/sky2?

Hi,

we are using sk98lin driver.

Kind regards

Flo
