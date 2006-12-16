Return-Path: <linux-kernel-owner+w=401wt.eu-S1030811AbWLPI57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030811AbWLPI57 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 03:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030813AbWLPI57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 03:57:59 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1436 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030811AbWLPI57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 03:57:59 -0500
Date: Sat, 16 Dec 2006 08:57:48 +0000
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: How to interpret PM_TRACE output
Message-ID: <20061216085748.GE4049@ucw.cz>
References: <20061213212258.GA9879@dose.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061213212258.GA9879@dose.home.local>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-12-06 22:22:59, Tino Keitel wrote:
> Hi folks,
> 
> I tried PM_TRACE to find the driver that breaks resume from suspend.
> I got working resume until I switched to the sk98lin driver
> (because sky2 doesn't support wake on LAN). That's why I was quite sure that
> sk98lin is the culprit, but I tried PM_TRACE anymay.

See Doc*/power/*.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
