Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932757AbVHSXvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757AbVHSXvn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932762AbVHSXvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:51:43 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:17565 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932760AbVHSXvm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 19:51:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B6/UNOun1hkVi7HU28AuDWAg+7KaN4qinWzPGy5VFQhgM6o836ApVRFejObdo4OqSim8SFOw1lDNdP06fjhKlH8zouuuAFQsohP7CvKtL3VSarPZvDp8MbZGUGH97aMXneK7q4xYRo/DkNiTZzLFq8XHKlEm0FeEodWx6+gPOpM=
Message-ID: <58cb370e050819165162278e61@mail.gmail.com>
Date: Sat, 20 Aug 2005 01:51:36 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] ide update
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1124474768.32050.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.GSO.4.62.0508182332470.22579@mion.elka.pw.edu.pl>
	 <1124406535.20755.12.camel@localhost.localdomain>
	 <58cb370e0508190202b0c5a5a@mail.gmail.com>
	 <1124474768.32050.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2005-08-19 at 11:02 +0200, Bartlomiej Zolnierkiewicz wrote:
> > lkml.org/lkml/2005/1/27/20
> >
> > AFAIK CS5535 driver was never ported to 2.6.x.  Somebody needs to
> > port it to 2.6.x kernel, cleanup to match kernel coding standards and test.
> 
> That was done some time ago and posted to various people.

This is a good news that cs5530 driver was ported.

BTW posting to "various people" is really not the best method of submitting
kernel patches (in this case linux-ide@vger.kernel.org + cc: me is).

Bartlomiej
