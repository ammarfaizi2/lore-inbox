Return-Path: <linux-kernel-owner+w=401wt.eu-S932825AbWLNPtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825AbWLNPtM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932828AbWLNPtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:49:12 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47347 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932825AbWLNPtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:49:10 -0500
Message-ID: <4581726B.9050006@garzik.org>
Date: Thu, 14 Dec 2006 10:48:59 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Rik van Riel <riel@redhat.com>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
References: <20061214003246.GA12162@suse.de>	<22299.1166057009@lwn.net>	<20061214005532.GA12790@suse.de>	<20061214051015.GA3506@nostromo.devel.redhat.com>	<20061214084820.GA29311@suse.de>	<4581595C.7080508@redhat.com> <20061214154734.189a23c6@localhost.localdomain>
In-Reply-To: <20061214154734.189a23c6@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> Another thing we should do more is aggressively merge prototype open
> drivers for binary only hardware - lets get Nouveau's DRM bits into the
> kernel ASAP for example.

ACK++  We should definitely push Nouveau[1] as hard as we can.

	Jeff


[1] http://nouveau.freedesktop.org/

