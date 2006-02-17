Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWBQPnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWBQPnY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWBQPnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:43:24 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:1818 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751494AbWBQPnX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:43:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uj+dYIfBVGV/aGChcmgtVg9SwK+u9FrNQ10cNRHAi4kwuw3hEuljlinzgLqRjCDP60LekqZOECk6Vjd+H6GvExDzu/pS47fZ4NpJjvIzbrhWWKxHEDYob14Zj7jKsZzPnMR8R/7aExuce3cEke4Vybhtoi1i6G1J4Fb1e5Ii6A4=
Message-ID: <58cb370e0602170743s5dd1adf9h34d8600adf7531d2@mail.gmail.com>
Date: Fri, 17 Feb 2006 16:43:21 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Fix IDE locking error.
Cc: "Dave Jones" <davej@redhat.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <1140190404.4283.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060216223916.GA8463@redhat.com>
	 <58cb370e0602170057x59b23957n3e858d5ac4918326@mail.gmail.com>
	 <1140186532.4283.2.camel@localhost.localdomain>
	 <58cb370e0602170653g30bd36f3j4b1a0e95f64ecbeb@mail.gmail.com>
	 <1140190404.4283.6.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2006-02-17 at 15:53 +0100, Bartlomiej Zolnierkiewicz wrote:
> > Thank you but this is not a patch description, this is a recipe
> > for me to spend nice friday's evening staring all over IDE code
> > and making patch description myself...
>
> Best I can do. I did the original analysis months and months ago when I
> fixed up that locking. Since then there have been enough changes that it
> may not be needed and I no longer remember the finer details

Even original analysis would be OK.

> > http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt ?
>
> I have better things to do. If you don't want the patch the its not my
> problem. I don't even use drivers/ide any more.

I want a patch but I would like to know more about it.

Bartlomiej
