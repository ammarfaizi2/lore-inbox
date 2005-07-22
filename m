Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVGVRrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVGVRrD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 13:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVGVRrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 13:47:03 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:7809 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261352AbVGVRrB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 13:47:01 -0400
Date: Fri, 22 Jul 2005 19:21:03 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: Patrick Draper <pdraper@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space
Message-ID: <20050722192103.GA8556@mars.ravnborg.org>
References: <20050711145616.GA22936@mellanox.co.il> <9a87484905072005596f2c2b51@mail.gmail.com> <m3pstd2jfu.fsf@defiant.localdomain> <6981e08b050722101241ba2f3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6981e08b050722101241ba2f3e@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2005 at 12:12:12PM -0500, Patrick Draper wrote:
> Why isn't a code formatting program used? People could write the code
> as they like to write it, then format it automatically in a standard
> way before it gets put into the kernel.
There is.
scripts/Lindent

But sometimes it fails to do the job properly and some hand formatting
is needed. Also much of the kernel is not new stuff but expanding or
fixing old stuff.

	Sam
