Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272238AbTGYRxj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 13:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272241AbTGYRxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 13:53:39 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:53004
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S272238AbTGYRxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 13:53:37 -0400
Date: Fri, 25 Jul 2003 11:08:47 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 -> 2.2 differences?
Message-ID: <20030725180847.GM1176@matchmail.com>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030725142434.GS32585@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725142434.GS32585@rdlg.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 10:24:34AM -0400, Robert L. Harris wrote:
> 
> 
> With all the SCO fun going on I have people asking me what functionality
> we would loose if we rolled from 2.4.21 kernel to the last known stable
> 2.2 kernel.
> 
> Yes, weathering the lawsuit mess and all is a good plan but I'm still
> being asked for this information.  Does anyone have a link listing what
>  kind of functionality would be lost, performance impact (p3 and athalon
> machines), etc?

No highmem support,

No journaled filesystems.

No netfilter.  Fewer networking features.  Period.  (ethernet bridging, etc)

Slower SMP

I don't know if it's psycological, but whenever I booted 2.2 on my desktop,
it felt slower.

This was a while ago though.

Mike
