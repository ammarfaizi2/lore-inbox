Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267497AbUJIWHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267497AbUJIWHu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 18:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267502AbUJIWHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 18:07:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46560 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267497AbUJIWHt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 18:07:49 -0400
Message-ID: <41686121.7060607@pobox.com>
Date: Sat, 09 Oct 2004 18:07:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
CC: Martins Krikis <mkrikis@yahoo.com>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com
Subject: Re: [Announce] "iswraid" (ICH5R/ICH6R ataraid sub-driver) for 2.4.28-pre3
References: <20041009204425.49483.qmail@web13725.mail.yahoo.com> <200410092337.36488.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200410092337.36488.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> I may sound like an ignorant but...
> 
> Why can't device mapper be merged into 2.4 instead?
> Is there something wrong with 2.4 device mapper patch?
> 
> It would more convenient (same driver for 2.4 and 2.6)
> and would benefit users of other software RAIDs
> (easier transition to 2.6).

OTOH, that would be introducing a brand new RAID/LVM subsystem in the 
middle of a stable series...

	Jeff


