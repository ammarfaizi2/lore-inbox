Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282028AbRKVDEN>; Wed, 21 Nov 2001 22:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282027AbRKVDEC>; Wed, 21 Nov 2001 22:04:02 -0500
Received: from mx3.sac.fedex.com ([199.81.208.11]:12041 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S282026AbRKVDDs>; Wed, 21 Nov 2001 22:03:48 -0500
Date: Thu, 22 Nov 2001 11:03:27 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dominik Kubla <kubla@sciobyte.de>, "Marcel J.E. Mol" <marcel@mesa.nl>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: New ac patch???
In-Reply-To: <E166VIr-0004ik-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0111221100460.10224-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/22/2001
 11:03:42 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/22/2001
 11:03:46 AM,
	Serialize complete at 11/22/2001 11:03:46 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, Alan Cox wrote:

> > > Not exaclty. It is a 48Gig drive in a dell inspiron 8000. I think it is
> > > IBM but the logs do not show a brandname. I can try open up the case tonight
> > > if you want to know for sure?
> >
> > It's an IBM IC25T048ATDA05-0 to be precise.
>
> Thanks. It seems IBM laptop drives are the ones that specifically need this
> fix. That ties in with the windows 98 reports/microsoft fixes.

I'm using IBM 240Z with IBM-DJSA-220 (20GB, 9.5mm thickness) with
2.4.15-pre7 and it does not need any fixes. Disk clean after shutdown.

Jeff.



