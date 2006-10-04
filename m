Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161542AbWJDQWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161542AbWJDQWb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161543AbWJDQWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:22:31 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:42372 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1161542AbWJDQWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:22:30 -0400
Date: Wed, 4 Oct 2006 18:19:19 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Announce: gcc bogus warning repository
Message-ID: <20061004161919.GB4096@wohnheim.fh-wedel.de>
References: <451FC657.6090603@garzik.org> <20061001100747.d1842273.rdunlap@xenotime.net> <451FF8ED.9080507@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <451FF8ED.9080507@garzik.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 October 2006 13:20:45 -0400, Jeff Garzik wrote:
> 
> If you have to grep useful stuff out of the noise, you've already lost.

My initial thought was to agree.  And I still almost agree with this
statement.

Almost, because every so often, it makes sense to see a shipload of
warnings and manually weed through them all.  99% will be false
positives, but there is the remaining 1% indicating real bugs.

Of course, once these have been dealt with, the warnings give 100%
noise and 0% useful output.  It is time to wait another year or four
before enough bugs have accumulated to make it worth the effort again.

That said, if you need to grep every day, you've definitely lost.

Jörn

-- 
Write programs that do one thing and do it well. Write programs to work
together. Write programs to handle text streams, because that is a
universal interface.
-- Doug MacIlroy
