Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267285AbSLRTnP>; Wed, 18 Dec 2002 14:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267331AbSLRTnO>; Wed, 18 Dec 2002 14:43:14 -0500
Received: from mx11.dmz.fedex.com ([199.81.193.118]:13327 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S267285AbSLRTnM>; Wed, 18 Dec 2002 14:43:12 -0500
Date: Thu, 19 Dec 2002 03:50:00 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: jchua@silk.corp.fedex.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Adam J. Richter" <adam@yggdrasil.com>,
       Andre Hedrick <andre@linux-ide.org>, <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.51 ide module problem
In-Reply-To: <1040227620.24530.18.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.42.0212190347300.10474-100000@silk.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/19/2002
 03:51:04 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/19/2002
 03:51:07 AM,
	Serialize complete at 12/19/2002 03:51:07 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Dec 2002, Alan Cox wrote:

> I'll get back to 2.5 IDE things next year. For the moment I'm only
> concerned in getting the modular stuff sorted out completely in 2.4.
> Hopefully that will be mostly valid for 2.5 as well.

I can't even boot 2.4.21-pre1 with IDE as modules. Works fine under 2.4.20

Looks like the IDE patch for 2.4.21-pre1 broke up the modules very similar
to 2.5.51

Thanks,
Jeff


