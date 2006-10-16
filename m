Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbWJPJkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWJPJkF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 05:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbWJPJkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 05:40:05 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:16532 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1030324AbWJPJkE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 05:40:04 -0400
Subject: Re: Driver model.. expel legacy drivers?
From: Kasper Sandberg <lkml@metanurb.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Richard Moser <nigelenki@comcast.net>,
       Kevin K <k_krieser@sbcglobal.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1160922815.5732.54.camel@localhost.localdomain>
References: <4530570B.7030500@comcast.net>
	 <20061014075625.GA30596@stusta.de> <4530FC8E.7020504@comcast.net>
	 <7E4CA247-AD0A-4A20-BEAF-CDD2CA4D3FFE@sbcglobal.net>
	 <45315A20.6090600@comcast.net>
	 <1160870637.5732.46.camel@localhost.localdomain>
	 <45317814.8000709@comcast.net>
	 <1160922815.5732.54.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 11:39:46 +0200
Message-Id: <1160991586.10100.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-15 at 15:33 +0100, Alan Cox wrote:
> Ar Sad, 2006-10-14 am 19:51 -0400, ysgrifennodd John Richard Moser:
> > > Microsoft are also being very helpful. They are making it harder and
> > > harder for people to use drivers not microsoft-signed which in turns
> > > pushes up costs for development and as a result encourages more
> > > standardization of driver interfaces to take place.
> > 
> > huh?
> 
> Every vendor of products for Microsoft Windows (which is still the
> primary market for all their hardware) has to provide drivers or work
> with pre-existing drivers. The harder Microsoft makes it (in financial
> terms) for them to produce drivers the more incentive they have to use
> the existing standards or to create new ones.
that makes very much sense, theres just one thing i dont understand.

when there is an established standard, how can it EVER be in a companys
best interrest to develop a new product that doesent use it, and thereby
requires the development of new drivers, the distributing of those
drivers, and all that sort?
> 
> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

