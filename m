Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267029AbSL3RoW>; Mon, 30 Dec 2002 12:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267030AbSL3RoW>; Mon, 30 Dec 2002 12:44:22 -0500
Received: from havoc.daloft.com ([64.213.145.173]:8931 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267029AbSL3RoV>;
	Mon, 30 Dec 2002 12:44:21 -0500
Date: Mon, 30 Dec 2002 12:52:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: Another holiday tg3 release
Message-ID: <20021230175237.GA2547@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another holiday, another set of tg3 releases.

first, there is an official, production update of tg3, version 1.2a:
http://people.redhat.com/jgarzik/tg3/tg3-1.2a/		(source code)
http://people.redhat.com/jgarzik/tg3/tg3-1.2a/rpms/	(red hat rpms)

second, for people still having problems, there are three experimental
sets of rpms, to be tried in this order:
http://people.redhat.com/jgarzik/tg3/tg3-1.2a/exp1-rpms/
http://people.redhat.com/jgarzik/tg3/tg3-1.2a/exp2-rpms/
http://people.redhat.com/jgarzik/tg3/tg3-1.2a/exp3-rpms/

experiment #1 - better irq mask/unmask for better speed and stability
		(test this!)
experiment #2 - ultra-safe version of #1, with less experimental stuff
experiment #3 - the riskiest of the bunch, but potentially faster

I would prefer that everyone who can try experiment #1, and back down to
experiment #2 if that doesn't work.

There is more information on the files in this directory in
http://people.redhat.com/jgarzik/tg3/tg3-1.2a/version-notes.txt

Disclaimer:  These are unofficial rpms created by myself.  They are not
officially released by Red Hat, so do not use them in production, etc.


