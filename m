Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264474AbTLCACJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 19:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbTLCACJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 19:02:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12715 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264474AbTLCACH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 19:02:07 -0500
Message-ID: <3FCD27EE.5030900@pobox.com>
Date: Tue, 02 Dec 2003 19:01:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
References: <3FCB8312.3050703@rackable.com> <877k1f9e1g.fsf@stark.dyndns.tv> <bqj41c$drr$1@gatekeeper.tmr.com> <20031202230216.GB4154@mis-mike-wstn.matchmail.com> <bqj6k0$e2p$1@gatekeeper.tmr.com>
In-Reply-To: <bqj6k0$e2p$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:
> Until multiple devices be string are available SATA will have logistical
> problems scaling. The small cable is an advantage running a few drives
> in a box, but a server with 40 drives or so would go from a cable bundle
> out the back, about 5cm by 1 cm, to a real bunch of those little round
> cables running everywhere. Certainly doable, but I think I'd name the
> server "Medusa" if I built it.


Sorry, SCSI is moving to point-to-point serial attachment (SAS), too :) 
    While not quite ready to call Parallel SCSI dead, it's definitely 
dying...

	Jeff



