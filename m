Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263569AbVCEBGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263569AbVCEBGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 20:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbVCEA5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:57:51 -0500
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:21673 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S263272AbVCEAvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:51:32 -0500
Date: Sat, 5 Mar 2005 08:51:04 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com
Subject: Re: BIOS overwritten during resume (was: Re: Asus L5D resume on battery power)
Message-ID: <20050305005103.GB4042@blackham.com.au>
References: <200502252237.04110.rjw@sisk.pl> <200503041415.35162.rjw@sisk.pl> <20050304201109.GB2385@elf.ucw.cz> <200503050026.06378.rjw@sisk.pl> <1109979448.3772.312.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109979448.3772.312.camel@desktop.cunningham.myip.net.au>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 10:37:29AM +1100, Nigel Cunningham wrote:
> On Sat, 2005-03-05 at 10:26, Rafael J. Wysocki wrote:
> > Yes, I think I'll just port the Nigel's patch to x86-64.  BTW, it's striking
> > that we found similar solutions independently (I didn't know the Nigel's
> > patch before :-)).
> 
> I should clarify credit. I didn't work on that code. I don't recall now
> whether it was Michael Frank or Bernard Blackham that came up with this
> version. (This was about a year ago IIRC).

Definitely not me, sorry :)

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>
