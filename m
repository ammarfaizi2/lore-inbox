Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264679AbTGKUP4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbTGKUPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:15:52 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:10379 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264679AbTGKUOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:14:39 -0400
Date: Fri, 11 Jul 2003 17:21:31 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Strange BK behaviour?
Message-ID: <Pine.LNX.4.55L.0307111715400.5537@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I just tagged v2.4.22-pre5 after pulling jgarzik's 2.4 net-drivers tree.

I cant seem to able able to push that tag to bkbits.net, though.

bkpush returns me:

Nothing to send to bk://linux@linux.bkbits.net/linux-2.4

Locally, I have:

ChangeSet@1.1079, 2003-07-11 16:11:39-03:00,
marcelo@freak.distro.conectiva
  Merge bk://kernel.bkbits.net/jgarzik/net-drivers-2.4
  into freak.distro.conectiva:/home/marcelo/bk/linux-2.4
  TAG: v2.4.22-pre5


Now going to the web interface shows the net-drivers-2.4 merge, but not
the TAG on it.

Whats going on?
