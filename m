Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311609AbSC1EeC>; Wed, 27 Mar 2002 23:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311618AbSC1Edw>; Wed, 27 Mar 2002 23:33:52 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:30470
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311609AbSC1Edg>; Wed, 27 Mar 2002 23:33:36 -0500
Date: Wed, 27 Mar 2002 20:32:50 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Chuck Campbell <campbell@neosoft.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, andersen@codepoet.org,
        Jos Hulzink <josh@stack.nl>, jw schultz <jw@pegasys.ws>,
        linux-kernel@vger.kernel.org
Subject: Re: DE and hot-swap disk caddies
In-Reply-To: <20020327222439.B13699@helium.inexs.com>
Message-ID: <Pine.LNX.4.10.10203272028580.6661-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Chuck,

You have me laughing and I love it, your signature!

What you are referring to is an bridge to a backplane, here is the voodoo
electronics.  If you check, I suspect that each drive is master mode, and
the tailgate generates the ID; where as the interface is more or less
SCA-SCSI.  SCA is an interface w/ all the tristating buffers intergrated.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Wed, 27 Mar 2002, Chuck Campbell wrote:

> On Wed, Mar 27, 2002 at 04:27:18PM -0800, Andre Hedrick wrote:
> > 
> > It requires more than what the average joe OS can do on its own.
> > 
> Not to be a nay-sayer, or even argue, I jsut wonder what the present
> hot swappable IDE raid devices are doing?
> 
> Are these built with all the necessary electronics, or are they just 
> rolling the dice?
> 
> I realise the OS only knows about the scsi interface to these, but they
> would appear to provide hot swappable IDE disks, albeit, using a scsi
> communication to the controller.
> 
> -chuck
> 
> -- 
> ACCEL Services, Inc.| Specialists in Gravity, Magnetics |  1(713)993-0671 ph.
>   1900 West Loop S. |   and Integrated Interpretation   |  1(713)993-0608 fax
>      Suite 900      |                                   |
>  Houston, TX, 77027 |          Chuck Campbell           | campbell@neosoft.com
>                     |  President & Senior Geoscientist  |
> 

