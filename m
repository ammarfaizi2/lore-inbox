Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755489AbWKQGtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489AbWKQGtZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 01:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755494AbWKQGtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 01:49:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42707 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1755489AbWKQGtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 01:49:22 -0500
Date: Thu, 16 Nov 2006 22:44:20 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Oleg Verych <olecom@flower.upol.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Looking for recent lkml email
Message-Id: <20061116224420.11c201e0.zaitcev@redhat.com>
In-Reply-To: <slrnelq3s1.7lr.olecom@flower.upol.cz>
References: <20061116162151.GA23930@tumblerings.org>
	<20061116165235.GA28447@tumblerings.org>
	<slrnelq3s1.7lr.olecom@flower.upol.cz>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.6; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 01:18:10 +0000 (UTC), Oleg Verych <olecom@flower.upol.cz> wrote:

> To do not produce megabytes of additional traffic in case of any
> kind of backlog and have anything you lkml like, i would suggest to have
> good news reader and point it to news.gmane.org service (well, i'm
> sure, there are many who have lkml->news scheme privately).

The good news reader might be a problem. In fact, I'm currently looking
for one. Criteria:
 - GUI with support for X clipboard (not just selections)
 - Ability to bounce to myself

I use Pan, but it cannot bounce articles. It only saves them, so I have
to find them (it uses Message-ID for name), open in vi, add "From xxx"
on top, then do the "Import External mbox" dance in my mailreader.
In previous Pan the useful trick was to "print" article, and specfy
your lpr to be a scrip which called sendmail. But they took it away.

-- Pete
