Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbUCHXxr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbUCHXxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:53:47 -0500
Received: from quasar.dynaweb.hu ([195.70.37.87]:54943 "EHLO quasar.dynaweb.hu")
	by vger.kernel.org with ESMTP id S261403AbUCHXxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:53:45 -0500
Date: Tue, 9 Mar 2004 00:53:38 +0100
From: Rumi Szabolcs <rumi_ml@rtfm.hu>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: Marvell PATA-SATA bridge meets 2.4.x
Message-Id: <20040309005338.376ae31d.rumi_ml@rtfm.hu>
In-Reply-To: <404CEEAF.5020608@matchmail.com>
References: <20040305231642.708841dd.rumi_ml@rtfm.hu>
	<404A9D14.5030107@matchmail.com>
	<20040308172839.17178753.rumi_ml@rtfm.hu>
	<404CEEAF.5020608@matchmail.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; sparc-sun-solaris2.9)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Mar 2004 14:07:43 -0800
Mike Fedyk <mfedyk@matchmail.com> wrote:

> >>You want to use a 2.6 kernel and talk to Bart, and Jeff about this...
> > 
> > Well, I don't really want a 2.6 kernel on that machine (yet) because
> > in my opinion it is not stable enough for a production system.
> 
> What problems are you having?

I'm just tracking lkml and seeing all the serious bug reports in 2.6
each day. Maybe 2.6.3 is really rock stable compared to what 2.4.3 was
like but compared to VMS 6.2 it looks about as stable as a barrel of
nitroglycerine, so I thought I better wait for at least 2.6.10
before even trying to put it on anything in production.

By the way, I wrote "in my opinion" to avoid starting a flame war on
that "is 2.6 stable already or not?" thing, now it seems like I've
failed... ;-)

So, until the reliability of 2.6 becomes acceptable for everyone I think
many people would appreciate fixes/backports for 2.4, especially for
those problems which don't take too much of an effort to fix.

Regards,
Szabolcs Rumi
