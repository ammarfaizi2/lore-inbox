Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbTFEJIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 05:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTFEJIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 05:08:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41992 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264542AbTFEJIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 05:08:48 -0400
Date: Thu, 5 Jun 2003 10:22:16 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
Message-ID: <20030605102216.E960@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	pcihpd-discuss@lists.sourceforge.net
References: <20030605013147.GA9804@kroah.com> <20030605021452.GA15711@kroah.com> <20030605083815.GA16879@suse.de> <20030605084933.GI2329@kroah.com> <20030605085938.GC16879@suse.de> <20030605090645.GA2887@kroah.com> <20030605091802.GA17356@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030605091802.GA17356@suse.de>; from davej@codemonkey.org.uk on Thu, Jun 05, 2003 at 10:18:02AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 10:18:02AM +0100, Dave Jones wrote:
>  > Getting rid of it entirely was the better
>  > option, and now that Linus has pulled it, we don't have to worry about
>  > it anymore :)
> 
> The fact that a tree-wide 'cleanup' like this goes in just a few hours
> after its posted before chance to comment is another argument, but
> concentrating on the technical point here, I still think this is a
> step backwards.

Indeed; especially when some people who need to comment aren't on US
time.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

