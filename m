Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751595AbWDCHAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbWDCHAV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 03:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbWDCHAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 03:00:21 -0400
Received: from mx1.suse.de ([195.135.220.2]:35007 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751595AbWDCHAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 03:00:20 -0400
Message-ID: <4430C7F2.6080408@suse.de>
Date: Mon, 03 Apr 2006 09:00:02 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: Jeff Dike <jdike@karaya.com>, Gerd Knorr <kraxel@strusel007.de>,
       linux-kernel@vger.kernel.org
Subject: Re: x11-fb driver
References: <20060331171418.GG2542@pengutronix.de>
In-Reply-To: <20060331171418.GG2542@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Gerd, are you still actively working on this driver?

Well, I rarely use UML these days, maybe that changes once the TLS
support bits are merged which hopefully makes it much easier to run
recent distros on UML.  Last time I tried (around 2.6.15) the driver
worked just fine for me.  Jeff had some problems to get it work on his
machine, not sure why, maybe you see the same problem, maybe the driver
must be adapted to some recent uml kernel changes ...

cheers,

  Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
http://www.suse.de/~kraxel/just-married.jpeg
