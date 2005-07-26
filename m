Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVGZPO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVGZPO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVGZPNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:13:14 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:61616 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261841AbVGZPLW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:11:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WVHX1WNMBoSxLS/LXl1Eg0kxmIVn7YXuXeFtDRUR6EpFSf6Tp1rjcMjW3XOVuorsjWVLFYuyUTNBEG69UWUh4XpeCSABVeM0ZVJ54ZTvehI41TaHjasRZLv3Kmi7cnXpdJX3FDHvozIzTofj4saAqaTxo9MlO8wKu0v3reYY9DI=
Message-ID: <3888a5cd05072608117abbc40a@mail.gmail.com>
Date: Tue, 26 Jul 2005 17:11:20 +0200
From: Linux Maillist <lnx4us@gmail.com>
Reply-To: Linux Maillist <lnx4us@gmail.com>
To: Rolf Eike Beer <eike@sf-mail.de>
Subject: Re: [PATCH] Remove Comtrol mail address from MAINTAINERS [next 1 address]
Cc: Jiri Slaby <xslaby@fi.muni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200507211007.44356@bilbo.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0507210139020.14792@localhost.localdomain>
	 <200507211007.44356@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/05, Rolf Eike Beer <eike@sf-mail.de> wrote:
> Am Donnerstag, 21. Juli 2005 01:43 schrieb Jiri Slaby:
> >Rolf Eike Beer wrotes:
> >>Send a patch, you know the addresses.
> >
> >kernel 2.6.13-rc3-git4
> >
> >Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
> >
> >--- a/MAINTAINERS      2005-07-21 01:13:32.000000000 +0200
> >+++ b/MAINTAINERS      2005-07-21 01:17:41.000000000 +0200
> >@@ -204,8 +204,6 @@
> >
> >  ADVANSYS SCSI DRIVER
> >  P:   Bob Frey
> >-M:    linux@advansys.com
> >-W:    http://www.advansys.com/linux.html
> >  L:   linux-scsi@vger.kernel.org
> >  S:   Maintained
> 
> Please do not remove this mail address until you have verified that it really
> does not exist and is not only rejected due to the broken mail setup of
> advansys.com. Removing the website is ok. The mail address you can remove is
> cjtsai@ali.com.tw.

This is letter from advansys (now initio):

>Hello Jiri,
>
>The links you have are very old and no longer work. Advansys went out of
He means these two, of course:
http://www.advansys.com/linux.html
linux@advansys.com
>busness about 3 years ago.
>
>There is no new development for linux and the Advansys products.
>
>Regards
>Dan
>Initio Technical Support

So now, removing both is OK.

cjtsai@ is from driver somewhere in the tree, not from MAINTAINERS, it
was my mistake.
