Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbUKJXnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUKJXnn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 18:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbUKJXnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 18:43:43 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:36035 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261741AbUKJXnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 18:43:40 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] 2.6.10-rc1-mm4: USB storage not working on AMD64
Date: Thu, 11 Nov 2004 00:42:25 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
References: <200411101154.05304.rjw@sisk.pl> <200411101557.51057.rjw@sisk.pl> <200411100736.08055.david-b@pacbell.net>
In-Reply-To: <200411100736.08055.david-b@pacbell.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411110042.25440.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 of November 2004 16:36, David Brownell wrote:
> On Wednesday 10 November 2004 06:57, Rafael J. Wysocki wrote:
> > On Wednesday 10 of November 2004 14:58, David Brownell wrote:
> 
> > > I recently posted several USB PM fixes that make things work better
> > > in my testing, and it sounds like they'd probably help here too.
> > 
> > Are they available as stand-alone patches?  I'd like to test ...
> 
> Yes, check the linux-usb-devel archives from Sunday evening.

Thanks a lot.  These patches evidently fix the problem described in this 
thread (verified on two different AMD64-based configurations).

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
