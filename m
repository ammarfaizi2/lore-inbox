Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWF0OUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWF0OUi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 10:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWF0OUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 10:20:38 -0400
Received: from aa003msr.fastwebnet.it ([85.18.95.66]:24722 "EHLO
	aa003msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932184AbWF0OUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 10:20:37 -0400
Date: Tue, 27 Jun 2006 16:20:41 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org
Subject: Re: 2.6.17-ck1: fcache problem...
Message-ID: <20060627162041.4560086d@localhost>
In-Reply-To: <20060627133544.GW22071@suse.de>
References: <20060625093534.1700e8b6@localhost>
	<20060625102837.GC20702@suse.de>
	<20060625152325.605faf1f@localhost>
	<20060625174358.GA21513@suse.de>
	<20060627112105.0b15bfa1@localhost>
	<20060627095443.GQ22071@suse.de>
	<20060627122457.2cabc4d7@localhost>
	<20060627150440.0aaf07e1@localhost>
	<20060627131033.GU22071@suse.de>
	<20060627153043.60582710@localhost>
	<20060627133544.GW22071@suse.de>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 15:35:45 +0200
Jens Axboe <axboe@suse.de> wrote:

> > > But it needs to be fixed of course, also so you don't have to do it for
> > > 'rw' remounts (which I sometimes do just to check stats).
> > 
> > I agree :)
> 
> Will fix it up, for now just pass fdev= always.

Ok.

-- 
	Paolo Ornati
	Linux 2.6.17-gd2581eb4 on x86_64
