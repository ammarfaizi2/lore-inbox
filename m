Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbTIOKrg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 06:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbTIOKrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 06:47:36 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:13722
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261346AbTIOKrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 06:47:35 -0400
Date: Mon, 15 Sep 2003 12:47:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Greg Stark <gsstark@mit.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Mike Fedyk <mfedyk@matchmail.com>, Antonio Vargas <wind@cocodriloo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: Andrea VM changes
Message-ID: <20030915104746.GE1394@velociraptor.random>
References: <Pine.LNX.4.55L.0308301248380.31588@freak.distro.conectiva> <Pine.LNX.4.55L.0308301607540.31588@freak.distro.conectiva> <Pine.LNX.4.55L.0308301618500.31588@freak.distro.conectiva> <20030830231904.GL24409@dualathlon.random> <1062339003.10208.1.camel@dhcp23.swansea.linux.org.uk> <87y8wq638s.fsf@stark.dyndns.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y8wq638s.fsf@stark.dyndns.tv>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 01:16:03AM -0400, Greg Stark wrote:
> http://groups.google.com/groups?threadm=3F510688.1050709%40colorfullife.com

btw, side note about the "swap space should be 2*physical memory" that's
not true anymore for a long time. Personally I normally install swap =
ram.

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
