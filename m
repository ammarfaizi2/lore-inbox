Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262947AbVCDRVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbVCDRVD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 12:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbVCDRSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 12:18:31 -0500
Received: from news.suse.de ([195.135.220.2]:49347 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262935AbVCDROX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 12:14:23 -0500
Message-ID: <42288F4F.7090504@suse.de>
Date: Fri, 04 Mar 2005 17:39:43 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, tpoynor@mvista.com
Subject: Re: [PATCH] kernel/power/disk.c trivial cleanups
References: <20050303231543.GA28559@slurryseal.ddns.mvista.com> <20050304091623.GA1551@elf.ucw.cz>
In-Reply-To: <20050304091623.GA1551@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> Duplicate remove killed, thanks. I do not think debugging print
> requires that much care...

I think it does. I tried s4bios ("firmware" mode) on hp 4150 today and
wondered why it said "mode set to firmware" but in fact did not do it.
You'll get a complete report for this later ;-)

Stefan

