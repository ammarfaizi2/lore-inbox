Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbTIOOGs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 10:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbTIOOGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 10:06:48 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:54432
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261397AbTIOOGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 10:06:47 -0400
Date: Mon, 15 Sep 2003 16:07:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: jpo234@netscape.net
Cc: remi.colinet@wanadoo.fr, linux-kernel@vger.kernel.org
Subject: Re: 1:1 M:N threading
Message-ID: <20030915140701.GN1394@velociraptor.random>
References: <1717A06D.56EB198A.00065BAA@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717A06D.56EB198A.00065BAA@netscape.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 05:12:59AM -0400, jpo234@netscape.net wrote:
> remi.colinet@wanadoo.fr wrote:
>  > For 2.6, the default is NGPT (see 
>  > http://www-124.ibm.com/developerworks/oss/pthreads/) which is 1:1.
> 
> NGPT is frozen and in maintenance mode (which is a different
> wording for "dead"). See
> http://www-124.ibm.com/pthreads/docs/announcement

and btw, NGPT isn't 1:1 but M:N.

Andrea

/*
 * If you refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */
