Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265066AbTLKOxn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 09:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbTLKOxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 09:53:42 -0500
Received: from zxa8020.lanisdn-gte.net ([206.46.31.146]:14032 "EHLO
	links.magenta.com") by vger.kernel.org with ESMTP id S265066AbTLKOxk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 09:53:40 -0500
Date: Thu, 11 Dec 2003 09:53:37 -0500
From: Raul Miller <moth@magenta.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
Message-ID: <20031211095337.A22341@links.magenta.com>
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <3FD7FCF5.7030109@cyberone.com.au> <3FD801B3.7080604@wmich.edu> <20031211054111.GX8039@holomorphy.com> <20031211094148.G28449@links.magenta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031211094148.G28449@links.magenta.com>; from moth@magenta.com on Thu, Dec 11, 2003 at 09:41:48AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 09:41:48AM -0500, I wrote:
> since the dark ages.  It's hard for me to comprehend how highmem, or 64
> bit cpus, could have much to do with a 1GB limit.

[Well, unless my motherboard really has a problem caching memory above
1GB.  But that seems unlikely, since it's the CPU which is acting as
the memory controller.  In any event, if this is actually the issue,
shouldn't the kernel issue a warning message, about why it's ignoring
the rest of the memory?]

Thanks again,

-- 
Raul Miller
moth@magenta.com
