Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVCITFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVCITFf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVCITCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:02:39 -0500
Received: from mail.tmr.com ([216.238.38.203]:15117 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262197AbVCITBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:01:14 -0500
Date: Wed, 9 Mar 2005 13:49:33 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.6.11-ac2
In-Reply-To: <1110392991.3072.222.camel@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1050309134506.4483A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005, Alan Cox wrote:

> 
> 2.6.11-ac2
> o	Merge 2.6.11.2					(Greg Kroah-Hartmann)
> 	including epoll error handling			(Georgi Guninski)
> 	| Theoretically security
> o	Fix a couple of pwc warnings			(Alan Cox)
> o	Ressurect epca driver				(Alan Cox)
> 
> 2.6.11-ac1
> o	Fix jbd race in ext3				(Stephen Tweedie)

You know what would be really useful... if www.kernel.org listed the
"latest -ac" patch as something current instead of 2.6.10-ac12, which was
a great patch in its day, but hasn't been current for a while.

In fairness, the -mm is out of date, too. Perhaps a bit of automation
would be appropriate here, so that no one would have to update this
manually.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

