Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267057AbSKSS7c>; Tue, 19 Nov 2002 13:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267079AbSKSS7b>; Tue, 19 Nov 2002 13:59:31 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:50104 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267057AbSKSS7a>; Tue, 19 Nov 2002 13:59:30 -0500
Subject: Re: Why can't Johnny compile?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dave@AFRInc.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211191257270.4170-100000@puppy.afrinc.com>
References: <Pine.LNX.4.44.0211191257270.4170-100000@puppy.afrinc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Nov 2002 19:34:41 +0000
Message-Id: <1037734481.12413.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-19 at 18:01, David G Hamblen wrote:
> On 19 Nov 2002, Alan Cox wrote:
> 
> > > things. Or the aha152x driver which I still can't get going in 2.5 :-(
> >
> > 152x seems to work
> > -
> 
> I'm running 2.5.47-ac4, and it compiles with aha152x, but pcmcia doesn't
> work:

Fixed in -ac6

