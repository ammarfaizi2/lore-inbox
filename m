Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967046AbWLDUsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967046AbWLDUsI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967130AbWLDUsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:48:08 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:37686 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967121AbWLDUsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:48:06 -0500
Message-ID: <45748984.2080006@garzik.org>
Date: Mon, 04 Dec 2006 15:48:04 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Thomas Meyer <thomas@m3y3r.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: ata_piix multithreaded device probes breaks detection of SCSI
 device
References: <4574865A.6030508@m3y3r.de>
In-Reply-To: <4574865A.6030508@m3y3r.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Meyer wrote:
> head: d916faace3efc0bf19fe9a615a1ab8fa1a24cd93
> 
> Here a sequential probe, that boots fine:

Known problem, unfortunately, for a -great- many drivers.

Please turn off this option until the authors fix it.

	Jeff



