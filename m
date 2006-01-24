Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbWAXIH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWAXIH3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 03:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWAXIH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 03:07:29 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49887 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030271AbWAXIH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 03:07:28 -0500
Date: Tue, 24 Jan 2006 09:07:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsusp: use bytes as image size units
Message-ID: <20060124080719.GA1604@elf.ucw.cz>
References: <200601240032.26735.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601240032.26735.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch makes swsusp use bytes as the image size units, which is needed
> for future compatibility.
> 
> The patch changes the behavior of the /sys/power/image_size attribute already
> present in 2.6.16-rc1, so it is against this kernel.
> 
> Please apply (Pavel, please ack).

ACKed.
								Pavel

-- 
Thanks, Sharp!
