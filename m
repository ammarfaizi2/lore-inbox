Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424127AbWKPPEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424127AbWKPPEG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 10:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424131AbWKPPEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 10:04:06 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5814 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1424130AbWKPPED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 10:04:03 -0500
Date: Thu, 16 Nov 2006 16:03:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <nigel@suspend2.net>, David Chinner <dgc@sgi.com>
Subject: Re: [PATCH -mm 1/2] Support for freezeable workqueues
Message-ID: <20061116150346.GC4703@elf.ucw.cz>
References: <200611160912.51226.rjw@sisk.pl> <200611160915.07135.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611160915.07135.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Make it possible to create a workqueue the worker thread of which will be
> frozen during suspend, along with other kernel threads.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
