Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267358AbSLRV4F>; Wed, 18 Dec 2002 16:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267362AbSLRV4B>; Wed, 18 Dec 2002 16:56:01 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41961
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267358AbSLRVzW>; Wed, 18 Dec 2002 16:55:22 -0500
Subject: Re: 2.5.51 ide module problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Chua <jchua@fedex.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>,
       Andre Hedrick <andre@linux-ide.org>, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.42.0212190347300.10474-100000@silk.corp.fedex.com>
References: <Pine.LNX.4.42.0212190347300.10474-100000@silk.corp.fedex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Dec 2002 22:43:42 +0000
Message-Id: <1040251422.26521.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 19:50, Jeff Chua wrote:
> 
> On 18 Dec 2002, Alan Cox wrote:
> 
> > I'll get back to 2.5 IDE things next year. For the moment I'm only
> > concerned in getting the modular stuff sorted out completely in 2.4.
> > Hopefully that will be mostly valid for 2.5 as well.
> 
> I can't even boot 2.4.21-pre1 with IDE as modules. Works fine under 2.4.20
> 
> Looks like the IDE patch for 2.4.21-pre1 broke up the modules very similar
> to 2.5.51

Yes it did, and I plan to fix it there first

