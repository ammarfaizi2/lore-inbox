Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288871AbSAERBN>; Sat, 5 Jan 2002 12:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288872AbSAERBD>; Sat, 5 Jan 2002 12:01:03 -0500
Received: from florence.ie.alphyra.com ([193.120.224.170]:37505 "EHLO
	florence.ie.alphyra.com") by vger.kernel.org with ESMTP
	id <S288871AbSAERAw>; Sat, 5 Jan 2002 12:00:52 -0500
Date: Sat, 5 Jan 2002 17:00:31 +0000 (GMT)
From: Paul Jakma <paulj@alphyra.ie>
X-X-Sender: <paulj@dunlop.dub.ie.alphyra.com>
To: Dave Jones <davej@suse.de>
cc: <knobi@knobisoft.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
In-Reply-To: <20020104221729.A5688@suse.de>
Message-ID: <Pine.LNX.4.33.0201051659040.15928-100000@dunlop.dub.ie.alphyra.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Dave Jones wrote:

>  When devicefs is ready (or more to the point, the drivers become
>  devicefs aware), something to the effect of ls -R /devices 
>  should be possible.

how does devicefs differ from devfs? eg, on some of my systems i mount 
devfs on /devfs and an ls -l of it shows all the devices that 
currently have drivers that registered them.

> Dave.

--paulj

