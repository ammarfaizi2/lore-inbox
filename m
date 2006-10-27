Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946309AbWJ0KHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946309AbWJ0KHK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 06:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946308AbWJ0KHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 06:07:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:8600 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946309AbWJ0KHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 06:07:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ws/itEeJgI8eR/R8dJCumJfI9YwFuhTcaIgT5lL4G/C0dx1HGCVjY+PhMkfkY4r77mb1LX9ieusas9YU/u5H6Rw8h+xwKJWL14D/bYwyGzuy9/vfF5Evj65hn/RnHYk5w2rHkpMHV5yL1AOacYFbndW7S7waH0vQJ2PHCzCoxBE=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: pharon@gmail.com
Subject: Re: O2 micro OZ711Mx mmc driver
Date: Fri, 27 Oct 2006 12:05:14 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-mmc@drzeus.cx>
References: <1161936280.3937.4.camel@localhost.localdomain>
In-Reply-To: <1161936280.3937.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610271205.14881.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 October 2006 10:04, Islam Amer wrote:
> Hi all. Sorry for sending again, but my email didn't reach LKML, for
> some reason.
> 
> Here it is through the web interface ..
> 
> http://lkml.org/lkml/2006/10/26/181
> 
> In short I have contacted O2 Micro for a driver for my MMC card reader
> OZ711Mx and they sent me a driver tarball under the GPL. It is made for
> 2.6.16 and doesn't compile with recent kernels.
> 
> I fixed it to compile but it still doesn't work. I am trying as hard as
> I can to fix it but my programming knowledge is limited. Any help is
> appreciated.

You need to provide more details. Just "doesn't work" is
nearly the worst bug report possible.

I failed to find the tarball on that page.

If it is really GPLed, there is no reason why it cannot be merged
into mainline (after necessary cleanups).
--
vda
