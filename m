Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267570AbUGWHdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267570AbUGWHdF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 03:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267571AbUGWHdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 03:33:05 -0400
Received: from puzzle.sasl.smtp.pobox.com ([207.8.226.4]:31383 "EHLO
	puzzle.pobox.com") by vger.kernel.org with ESMTP id S267570AbUGWHdD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 03:33:03 -0400
Date: Fri, 23 Jul 2004 00:33:00 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interesting race condition...
Message-ID: <20040723073300.GA4502@ip68-4-98-123.oc.oc.cox.net>
References: <200407222204.46799.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407222204.46799.rob@landley.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 10:04:46PM -0500, Rob Landley wrote:
> Seems like some kind of race condition, dunno if it's in Fedore Core 1's ps
> or the 2.6.7 kernel or what...

I've seen this too, on Fedora Core 2 and pretty recent (within the last
2 weeks) fc-devel. Hard enough to reproduce (and not enough of a bother
IMO) that I haven't filed it in Bugzilla though.

(Now that you mention Fedora Core, I can't remember seeing this with any
other distributions.)

-Barry K. Nathan <barryn@pobox.com>

