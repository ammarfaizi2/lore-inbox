Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbTHTV2b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 17:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbTHTV2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 17:28:31 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:24588 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262235AbTHTV2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 17:28:30 -0400
Date: Wed, 20 Aug 2003 22:28:28 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Greg KH <greg@kroah.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [RFC] add class/video to fb drivers - Take 2
In-Reply-To: <20030820212626.GA4854@kroah.com>
Message-ID: <Pine.LNX.4.44.0308202227490.9662-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, it's not "ideal" but it will do for 2.6 to use this patch.  If you
> look at the tty core, it's the same way that currently works.
> 
> Ideally in 2.7 I'd like to convert to have all fb drivers create the
> fb_info structure dynamically, but that's much to big of a change to do
> this late in the 2.6 development cycle.

What is the advantage of creating every fb_info dynamically?


