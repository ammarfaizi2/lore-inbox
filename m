Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbUBHQVv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 11:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbUBHQVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 11:21:50 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:8101 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263777AbUBHQVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 11:21:49 -0500
Subject: Re: [PROBLEM] 2.6.3-rc1: still no suspend/resume on Centrino
	notebook (contains agp, lapic, swsusp)
From: Matthias Hentges <mailinglisten@hentges.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <c05m86$20g$1@sea.gmane.org>
References: <200402081522.i18FMVl7001382@brain.gnuhh.org>
	 <c05m86$20g$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1076257326.1055.2.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 08 Feb 2004 17:22:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am So, den 08.02.2004 schrieb Ari Pollak um 16:57:
> I should clarify that this does not happen on *all* Centrino notebooks 
> (and not the ones I've tried), only some.

Indeed. I own a Samsung P30 XVM 1500 Centrino laptop. It suspends just
fine in kernel 2.6.2-mm1 but it wont wake up.

The difference is that i don't get any messages in /v/l/m or /v/l/m.

Hopefully this will get fixed.
-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian Woody. Geek by Nature, Linux by Choice


