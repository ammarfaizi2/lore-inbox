Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWEPPdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWEPPdm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWEPPdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:33:41 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:60048 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751234AbWEPPdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:33:40 -0400
Date: Tue, 16 May 2006 17:33:18 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Brownell <david-b@pacbell.net>
Cc: jffs-dev@axis.com, dwmw2@infradead.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
Subject: Re: jffs2 build fixes
Message-ID: <20060516153318.GE11656@wohnheim.fh-wedel.de>
References: <200604010831.57875.david-b@pacbell.net> <200605160755.38606.david-b@pacbell.net> <20060516150928.GC11656@wohnheim.fh-wedel.de> <200605160825.54972.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200605160825.54972.david-b@pacbell.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006 08:25:52 -0700, David Brownell wrote:
> On Tuesday 16 May 2006 8:09 am, Jörn Engel wrote:
> 
> > jffs-dev@axis.com is practically dead.  Iirc, the list was used for
> > the old jffs[1] code.  Jffs2 is usually discussed on
> > linux-mtd@lists.infradead.org (added to Cc:).
> 
> Then it's overdue for the MAINTAINERS file to be updated ... it
> seems wrong that the official "where to go" listing for JFFS2
> points at a black hole.

Ouch!  Yes, you are correct.

Can you send a patch to dwmw2?

Jörn

-- 
Write programs that do one thing and do it well. Write programs to work
together. Write programs to handle text streams, because that is a
universal interface. 
-- Doug MacIlroy
