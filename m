Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbTEPGas (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 02:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbTEPGar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 02:30:47 -0400
Received: from ms-smtp-01.southeast.rr.com ([24.93.67.82]:22963 "EHLO
	ms-smtp-01.southeast.rr.com") by vger.kernel.org with ESMTP
	id S264310AbTEPGar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 02:30:47 -0400
From: Boris Kurktchiev <techstuff@gmx.net>
Reply-To: techstuff@gmx.net
To: Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: The kernel is miscalculating my RAM...
Date: Fri, 16 May 2003 02:48:33 -0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200305131415.37244.techstuff@gmx.net> <200305160003.25262.techstuff@gmx.net> <3EC47A57.30407@nortelnetworks.com>
In-Reply-To: <3EC47A57.30407@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305160248.33755.techstuff@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday May 16 2003 1:42 am, Chris Friesen wrote:
> Boris Kurktchiev wrote:
> > ok here is what dmesg shows:
> > 384MB LOWMEM available.
> >
> > then further down:
> > Memory: 385584k/393216k available
> >
> > now how is the little 38.../39... possible?
>
> 384 * 1024 * 1000 = 393216000
ahh so I am reading it wrong... ok but where is the 7mbs going? I think I 
amreading it right this time... and it says that it only uses 385584k as 
opposed to the full 393216k... btw the same thing happens with swap there are 
only 2mbs eaten up from it though... (I have 128mb and I get only 127mb)
