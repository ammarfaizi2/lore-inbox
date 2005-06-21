Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVFUOg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVFUOg5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 10:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVFUOew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 10:34:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61586 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261480AbVFUObq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 10:31:46 -0400
Date: Tue, 21 Jun 2005 16:16:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: -mm -> 2.6.13 merge status (Suspend-to-disk)
Message-ID: <20050621141642.GA2015@openzaurus.ucw.cz>
References: <20050620235458.5b437274.akpm@osdl.org> <1119359295.10186.1150.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119359295.10186.1150.camel@localhost>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > kexec and kdump
> > 
> >     I guess we should merge these.
> > 
...
> No potential clashes with suspend code, I assume?
> 

I test suspend in -mm series from time to time, and it seems ok;
so this one should be safe.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

