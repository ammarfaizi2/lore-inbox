Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUJIEXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUJIEXn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 00:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266467AbUJIEXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 00:23:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1424 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266473AbUJIEXi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 00:23:38 -0400
Message-ID: <416767BA.1020204@pobox.com>
Date: Sat, 09 Oct 2004 00:23:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: Greg KH <greg@kroah.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [openib-general] InfiniBand incompatible with the Linux kernel?
References: <20041008202247.GA9653@kroah.com> <528yagn63x.fsf@topspin.com>	<41673772.9010402@pobox.com> <52zn2wlh8h.fsf@topspin.com>
In-Reply-To: <52zn2wlh8h.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Jeff> Read the member agreement :) It -explicitly- does -not-
>     Jeff> require waiving of patent claims related to any
>     Jeff> implementation of IB.
> 
>     Jeff> That's different from ATA, SCSI, USB, the list goes on...
> 
> Fair enough, but read the Bluetooth SIG patent agreement [1].  As far
> as I can tell, all it requires is that other SIG members receive a
> patent license.  Do we need to do rm -rf net/bluetooth?  IEEE only
> requires that patents be licensed under RAND terms (it does not even
> require royalty free licensing) [2].  Time for rm -rf drivers/ieee1394?

As my mother would ask, would you jump off a cliff just because your 
friend did?

If there is questionable code, that is _not_ a justification to add more.

	Jeff


