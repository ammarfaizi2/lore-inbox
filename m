Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310257AbSCSGoD>; Tue, 19 Mar 2002 01:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310248AbSCSGnx>; Tue, 19 Mar 2002 01:43:53 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:54955 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S310257AbSCSGnk>; Tue, 19 Mar 2002 01:43:40 -0500
Date: Tue, 19 Mar 2002 08:25:26 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7-pre1 oops in rtnetlink
In-Reply-To: <200203181805.VAA27506@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.44.0203190824520.25705-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002 kuznet@ms2.inr.ac.ru wrote:

> Hello!
> 
> > I can reproduce by doing an ifdown eth0; ifconfig. 
> > kernel is 2.5.7-pre1 SMP
> 
> What is the device?

If you mean device driver, i duplicated it with a 3com and a Tulip.
	
	Zwane


