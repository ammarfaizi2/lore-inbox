Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269443AbUINPrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269443AbUINPrb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269440AbUINPrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:47:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4064 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269443AbUINPqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:46:13 -0400
Message-ID: <41471237.2040806@pobox.com>
Date: Tue, 14 Sep 2004 11:45:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "C.Y.M." <syphir@syphir.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAjtLAU+gqyUq8AePOBiNtXQEAAAAA@syphir.sytes.net> <20040914060628.GC2336@suse.de> <1095156346.16572.2.camel@localhost.localdomain> <41470BBD.7060700@pobox.com> <20040914152509.GA27892@suse.de> <41470F3A.1060308@rtr.ca>
In-Reply-To: <41470F3A.1060308@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Flash cards should be detectable --> many of them will claim
> to implement the CFA feature set.

many but not all ;-)

