Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263683AbUCUSM1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 13:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbUCUSM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 13:12:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13212 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263683AbUCUSMZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 13:12:25 -0500
Message-ID: <405DDAFC.3020504@pobox.com>
Date: Sun, 21 Mar 2004 13:12:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Mason <mason@suse.com>, "Mudama, Eric" <eric_mudama@Maxtor.com>
Subject: Re: [PATCH] barrier patch set
References: <20040319153554.GC2933@suse.de> <20040320101929.GF2711@suse.de> <405C1EF2.9070201@pobox.com> <200403201730.38266.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403201730.38266.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> They don't misreport!  They comply with the spec (ATA-4 or ATA-5).
> 
> Jeff, please RTFSPEC. ;-)

Arrrrgh.  Yes, you're right, and I stand corrected.

One wonders why the bits appeared at all, then...   I wonder if some ATA 
drives _don't_ support mandatory flush-cache command?  grumble.

	Jeff



