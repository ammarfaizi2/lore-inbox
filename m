Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318083AbSGMDQi>; Fri, 12 Jul 2002 23:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318085AbSGMDQh>; Fri, 12 Jul 2002 23:16:37 -0400
Received: from air-2.osdl.org ([65.172.181.6]:59532 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S318083AbSGMDQg>;
	Fri, 12 Jul 2002 23:16:36 -0400
Date: Fri, 12 Jul 2002 20:17:14 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Thunder from the hill <thunder@ngforever.de>
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Compile warning in fs/partitions/check.c
In-Reply-To: <Pine.LNX.4.44.0207121719340.3421-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.33.0207122016230.961-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Jul 2002, Thunder from the hill wrote:

> Hi,
> 
> > And I don't think Richard really wants to be bothered with driverfs
> > questions :)
> 
> kernel oops at fs/partitions/check.c:-1!

Could you post the decoded output of the oops, and specify what patches 
you have applied (and modified).

Thanks,

	-pat

