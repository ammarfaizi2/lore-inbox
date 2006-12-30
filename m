Return-Path: <linux-kernel-owner+w=401wt.eu-S1753367AbWL3XeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbWL3XeB (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 18:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754416AbWL3XeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 18:34:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40435 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753367AbWL3XeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 18:34:00 -0500
Message-ID: <4596F760.9010105@redhat.com>
Date: Sat, 30 Dec 2006 18:33:52 -0500
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Alexander Nagel <feuerschwanz76@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: new harddrive with media error
References: <en6q3j$2jk$1@sea.gmane.org>
In-Reply-To: <en6q3j$2jk$1@sea.gmane.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nagel wrote:
> Hi all,
> 
> i installed a new drive (WDC WD5000KS-00M) in my computer and installed 
> WinXP on it. Afterwards i installed Debian etch on the second one 
> (HDS722512VLSA80). Everything works fine so far, but during every boot i 
> get following messages in dmesg [1]
> Kernel [2] is 2.6.18 as default kernel in etch.
> the board is a asusboard with via chipset [3]
> The problem is that the boottime is very long, for every "media error" ~ 
> 3 sec. :-(

That's because your hard disk has errors.

Maybe not on the whole disk, but some parts of the disk are
certainly broken.  It's a good thing you discovered this so
soon after installation, and are not relying on it yet with
all your personal data.

You'll want to exchange the disk for one without media errors.

-- 
Politics is the struggle between those who want to make their country
the best in the world, and those who believe it already is.  Each group
calls the other unpatriotic.
