Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265035AbUFANd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265035AbUFANd0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 09:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbUFANdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 09:33:25 -0400
Received: from gprs214-153.eurotel.cz ([160.218.214.153]:12928 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265035AbUFANdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 09:33:18 -0400
Date: Tue, 1 Jun 2004 15:32:29 +0200
From: Pavel Machek <pavel@suse.cz>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040601133228.GB5926@elf.ucw.cz>
References: <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de> <20040526130500.GB18028@devserv.devel.redhat.com> <20040526164129.GA31758@wohnheim.fh-wedel.de> <20040601055616.GD15492@wohnheim.fh-wedel.de> <20040601060205.GE15492@wohnheim.fh-wedel.de> <20040601122013.GA10233@elf.ucw.cz> <20040601132712.GB14572@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040601132712.GB14572@wohnheim.fh-wedel.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Perhaps some other format of comment should be introduced? Will not
> > this interfere with linuxdoc?
> 
> I'm open for suggestions. ;)

/*! Recursion-count: 2 Whatever-else: 5 */

?
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
