Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265047AbUFAN1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265047AbUFAN1e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 09:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265045AbUFAN1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 09:27:34 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:36039 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265037AbUFAN1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 09:27:30 -0400
Date: Tue, 1 Jun 2004 15:27:12 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040601132712.GB14572@wohnheim.fh-wedel.de>
References: <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de> <20040526130500.GB18028@devserv.devel.redhat.com> <20040526164129.GA31758@wohnheim.fh-wedel.de> <20040601055616.GD15492@wohnheim.fh-wedel.de> <20040601060205.GE15492@wohnheim.fh-wedel.de> <20040601122013.GA10233@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040601122013.GA10233@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 June 2004 14:20:13 +0200, Pavel Machek wrote:
> 
> Perhaps some other format of comment should be introduced? Will not
> this interfere with linuxdoc?

I'm open for suggestions. ;)

Jörn

-- 
Data dominates. If you've chosen the right data structures and organized
things well, the algorithms will almost always be self-evident. Data
structures, not algorithms, are central to programming.
-- Rob Pike
