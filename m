Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265452AbUAHQ0y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 11:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265549AbUAHQZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 11:25:48 -0500
Received: from dsl017-022-215.chi1.dsl.speakeasy.net ([69.17.22.215]:46862
	"EHLO gateway.two14.net") by vger.kernel.org with ESMTP
	id S265528AbUAHQZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 11:25:23 -0500
Date: Thu, 8 Jan 2004 10:25:08 -0600
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: maney@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.4.22-rc2 ext2 filesystem corruption
Message-ID: <20040108162508.GA4017@furrr.two14.net>
Reply-To: maney@pobox.com
References: <200310311941.31930.bzolnier@elka.pw.edu.pl> <20040104011222.GA1433@furrr.two14.net> <200401040307.48530.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401040307.48530.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.3.28i
From: maney@two14.net (Martin Maney)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 03:07:48AM +0100, Bartlomiej Zolnierkiewicz wrote:
> I see nothing in 2.4.23 which can explain this.
> Probably if you boot from Promise you will see corruption again.

If tin's flags are correct I forgot to reply to this after testing
that.  In fact I did *not* observe the corruption when I booted from
the Promise, but I didn't have the same file (an XFree86 source
archive) that I was using previously.  I think I know which version it
was, and I'll see about retesting with that.  If that works I'll try to
recreate a kernel of the version I originally encountered this with and
try that.  Probably won't have time until the weekend, what with the
twins' birthday party this evening.

-- 
The trouble with customizing your environment is that it just doesn't
propagate, so it's not even worth the trouble.  -- Joel Spolsky

I keep my life in a CVS repository. -- Joey Hess

