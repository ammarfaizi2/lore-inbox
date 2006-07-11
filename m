Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWGKWlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWGKWlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWGKWlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:41:09 -0400
Received: from ns.suse.de ([195.135.220.2]:13772 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751339AbWGKWlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:41:08 -0400
Date: Tue, 11 Jul 2006 15:36:41 -0700
From: Greg KH <gregkh@suse.de>
To: David Lang <dlang@digitalinsight.com>
Cc: Adrian Bunk <bunk@stusta.de>, Michael Krufky <mkrufky@linuxtv.org>,
       Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, stable@kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.16.y series
Message-ID: <20060711223641.GA2258@suse.de>
References: <20060706222553.GA2946@kroah.com> <20060707105407.GA1654@elf.ucw.cz> <44AE558D.9000906@linuxtv.org> <20060710165429.GB13938@stusta.de> <Pine.LNX.4.63.0607100942550.1768@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607100942550.1768@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 09:43:36AM -0700, David Lang wrote:
> On Mon, 10 Jul 2006, Adrian Bunk wrote:
> 
> >
> >Greg told me they want to make one last 2.6.16.y release.
> >
> >Greg and Chris don't maintain two series that long - check the date of
> >the last 2.6.15.y release.
> 
> they haven't in the past, but I thought the stated plan was to support 
> -stable for two revs back going forward.

Hm, I don't remember saying that anywhere, I was thinking we (Chris and
I) were agreeing to maintain the last full version for a few releases,
like we are currently doing.

Hopefully I can flush the last 2.6.16 patches out this week and then
hand it over to Adrian for him to have his way with it :)

thanks,

greg k-h
