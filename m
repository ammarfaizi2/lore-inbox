Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272247AbTHNIt2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 04:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272248AbTHNIt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 04:49:28 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:58327 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S272247AbTHNIt0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 04:49:26 -0400
Date: Thu, 14 Aug 2003 11:49:20 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Oleg Drokin <green@namesys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test2mm4 reiser bug? Buffer I/O error on device hda2,
 logica...
In-Reply-To: <20030813155407.GA27436@namesys.com>
Message-ID: <Pine.LNX.4.56.0308141148440.10006@hosting.rdsbv.ro>
References: <Pine.LNX.4.56.0308131151070.11964@hosting.rdsbv.ro>
 <20030813155407.GA27436@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Aug 13, 2003 at 11:55:25AM +0300, Catalin BOIE wrote:
>
> > But I get something like:
> > vs-8115: get_num_ver: not directory item
> > Do I have to worry?
>
> Time to get latest reiserfsprogs off ftp.namesys.com and check your
> filesystem it seems.

I had 3.6.8. Now I have 3.6.11 and seems that it found the error.
Thanks!

>
> Bye,
>     Oleg
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro
