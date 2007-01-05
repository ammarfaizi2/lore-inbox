Return-Path: <linux-kernel-owner+w=401wt.eu-S1751213AbXAFHb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbXAFHb0 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 02:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbXAFHb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 02:31:26 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2071 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751206AbXAFHbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 02:31:00 -0500
Date: Fri, 5 Jan 2007 17:34:43 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.20-rc3-git4 oops on suspend: __drain_pages
Message-ID: <20070105173443.GC4745@ucw.cz>
References: <459DB116.9070805@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459DB116.9070805@shaw.ca>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Saw this oops on 2.6.20-rc3-git4 when attempting to 
> suspend. This only happened in 1 of 3 attempts.

Find out how reproducible it is... and if it works with minimum
modules loaded.
						Pavel
-- 
Thanks for all the (sleeping) penguins.
