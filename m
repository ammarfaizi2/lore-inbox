Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbTGBQEz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 12:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265090AbTGBQEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 12:04:54 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:31439 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265065AbTGBQEx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 12:04:53 -0400
Date: Wed, 2 Jul 2003 09:19:06 -0700
From: Greg KH <greg@kroah.com>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: USB Serial oops in 2.4.22-pre2
Message-ID: <20030702161906.GB8281@kroah.com>
References: <200307021222.09764.harisri@bigpond.com> <20030702033417.GB3272@kroah.com> <200307021556.48174.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307021556.48174.harisri@bigpond.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 03:56:48PM +1000, Srihari Vijayaraghavan wrote:
> 
> I'm now searching the usb-devel archives to understand this issue, but do you 
> think the upcoming 2.4.22-pre3 might fix this issue?

I don't think anything in 2.4.22-pre2 caused this problem, it's been in
2.4.21 all along :)

But it's a timing issue, so if 2.4.21 is working for you, I'd suggest
sticking with that kernel for now.

Sorry I don't have a better answer.

greg k-h
