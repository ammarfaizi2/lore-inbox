Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266572AbUHaFE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266572AbUHaFE5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 01:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUHaFE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 01:04:56 -0400
Received: from mproxy.gmail.com ([216.239.56.249]:34109 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266572AbUHaFEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 01:04:54 -0400
Message-ID: <54b5dbf5040830220435b14550@mail.gmail.com>
Date: Mon, 30 Aug 2004 22:04:51 -0700
From: asterix the gual <asterixthegaul@gmail.com>
Reply-To: asterix the gual <asterixthegaul@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: [linux-usb-devel] Re: Summarizing the PWC driver questions/answers
In-Reply-To: <1093786799.27934.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <6.1.2.0.2.20040827215445.01c4ddb0@inet.uni2.dk>
	 <Pine.LNX.4.61.0408272259450.2771@dragon.hygekrogen.localhost>
	 <6.1.2.0.2.20040827233253.01c36210@inet.uni2.dk>
	 <200408280113.27530.oliver@neukum.org> <1093786799.27934.28.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One more to Gregkh's Q&A

Q. Is there anyother way to support the binary only driver?
A. Yes. You can maintain a separate linux-pwc tree with the necessary hooks :)




On Sun, 29 Aug 2004 14:40:00 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sad, 2004-08-28 at 00:13, Oliver Neukum wrote:
> > Keeping drivers against the wishes of the authors in the tree would
> > be very troubling for the future. I can assure you that no maintainer
> > will lightly pull a driver in this way.
> 
> Then the kernel community is no longer fit to use my code. So you should
> remove everything I've written from Linus kernel too. I'll maintain my
> own kernel.
> 
> Oh gosh, look I've just crippled Linus tree and stolen his project.
> Thats *WHY* you can't just rip drivers out. A license was granted, for
> ever. You can certainly remove him from maintainers, and if he insists
> from the author credits.
> 
> Alan
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
