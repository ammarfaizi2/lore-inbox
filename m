Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbTKXTf3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 14:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTKXTf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 14:35:29 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:7040 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S263876AbTKXTfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 14:35:25 -0500
Date: Mon, 24 Nov 2003 19:35:09 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Larry McVoy <lm@bitmover.com>, Ricky Beam <jfbeam@bluetronic.net>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: data from kernel.bkbits.net
Message-ID: <20031124193509.GA2220@mail.shareable.org>
References: <20031124155034.GA13896@work.bitmover.com> <Pine.GSO.4.33.0311241405070.13188-100000@sweetums.bluetronic.net> <20031124192432.GA20839@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031124192432.GA20839@work.bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> Any other questions?

At risk of sounding like second level support,

  1. Are you able to copy the raw partitions (e.g. using dd) to
     another disk or system?

  2. Do you see similar error messages when copying the raw partitions?

  3. When you mount the _copies_ of the partitions, do you see similar
     error messages?

That'll differentiate whether it's a pure disk/driver problem or
something triggered by a filesystem problem.  As a bonus, if the disks
are both dying (maybe you had a lightning strike), then you'll have
the data copied somewhere safe.

-- Jamie
