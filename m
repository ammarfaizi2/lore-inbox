Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbSKOBIq>; Thu, 14 Nov 2002 20:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbSKOBIq>; Thu, 14 Nov 2002 20:08:46 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:15629 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S265423AbSKOBIq>; Thu, 14 Nov 2002 20:08:46 -0500
Date: Fri, 15 Nov 2002 02:15:39 +0100
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, mikpe@csd.uu.se, mingo@redhat.com,
       rl@hellgate.ch, akpm@digeo.com
Subject: Re: Yet another IO-APIC problem (was Re: via-rhine weirdness with viakt8235 Southbridge)
Message-ID: <20021115021539.C17648@pc9391.uni-regensburg.de>
References: <20021115002822.G6981@pc9391.uni-regensburg.de> <20021115011738.D17058@pc9391.uni-regensburg.de> <3DD445EF.9080002@pobox.com> <3DD4481F.72627800@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3DD4481F.72627800@digeo.com>; from akpm@digeo.com on Fri, Nov 15, 2002 at 02:04:31 +0100
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Nov 2002 02:04:31 Andrew Morton wrote:
> Jeff Garzik wrote:
> >
> > ...
> > IMO we should just take out UP IOAPIC support in the kernel, or put a
> > big fat warning in the kernel config _and_ at boot...
> >
> 
> It would be nice to get it working, because oprofile needs it.
> 
> (Well, oprofile can use the rtc, but then it doesn't profile
> ints-off code)
> 

so, is there anything I could do for you in that IO-APIC case ? Especially in 
my via-rhine case? As I mentioned in my previous mail, would some via-diag, 
mii-diag outputs (what options) be helpful for you?

Christian
