Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbUJYQE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbUJYQE5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUJYQAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:00:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27592 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261990AbUJYPsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:48:25 -0400
Message-ID: <417D203B.4030508@pobox.com>
Date: Mon, 25 Oct 2004 11:48:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Urlichs <smurf@smurf.noris.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: BK kernel workflow
References: <41752E53.8060103@pobox.com> <20041019153126.GG18939@work.bitmover.com> <41753B99.5090003@pobox.com> <4d8e3fd304101914332979f86a@mail.gmail.com> <20041019213803.GA6994@havoc.gtf.org> <4d8e3fd3041019145469f03527@mail.gmail.com> <20041019232710.GA10841@kroah.com> <pan.2004.10.25.13.01.49.824742@smurf.noris.de>
In-Reply-To: <pan.2004.10.25.13.01.49.824742@smurf.noris.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Urlichs wrote:
> Andrew also does things like
> 
> bk-netdev.patch
> e1000-module_param-fix.patch
> ne2k-pci-pci-build-fix.patch
> r8169-module_param-fix.patch
> 
> which my mind translates as "there's something stupid, incomplete or
> outdated in the bk-netdev tree", or "that tree's maintainer should apply
> these patches. Now." (Ideally, of course, my import script should do the
> same thing.)

Wrong on all counts.

The right answer is, "bk-netdev conflicts with some other BK tree that's 
also not yet in upstream"

	Jeff


