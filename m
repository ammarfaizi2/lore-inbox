Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVBFQJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVBFQJy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 11:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVBFQJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 11:09:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24549 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261169AbVBFQJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 11:09:52 -0500
Message-ID: <42064141.6040003@pobox.com>
Date: Sun, 06 Feb 2005 11:09:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Arjan van de Ven <arjan@infradead.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Martins Krikis <mkrikis@yahoo.com>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
References: <87651hdoiv.fsf@yahoo.com> <420582C6.7060407@pobox.com> <1107682076.22680.58.camel@laptopd505.fenrus.org> <58cb370e050206044513eb7f89@mail.gmail.com> <42062BFE.7070907@pobox.com> <1107701373.22680.115.camel@laptopd505.fenrus.org> <420631BF.7060407@pobox.com> <20050206155017.GA1215@infradead.org>
In-Reply-To: <20050206155017.GA1215@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sun, Feb 06, 2005 at 10:03:27AM -0500, Jeff Garzik wrote:
> 
>>Red herring.
>>
>>2.4.x has ICH5/6 support -- but is missing the RAID support component.
>>
>>We are talking about hardware that is ALREADY supported by 2.4.x kernel, 
>>not new hardware.
> 
> 
> You're talking about software not support (the intel bios fakeraid format).

I'm talking about being able to access data, or not.

	Jeff



