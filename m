Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbUJZNLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbUJZNLw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 09:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbUJZNLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 09:11:52 -0400
Received: from main.gmane.org ([80.91.229.2]:26785 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262251AbUJZNLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 09:11:50 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: BK kernel workflow
Date: Tue, 26 Oct 2004 15:09:51 +0200
Message-ID: <MPG.1be851949613aa2e989702@news.gmane.org>
References: <20041023161253.GA17537@work.bitmover.com> <4d8e3fd304102403241e5a69a5@mail.gmail.com> <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com> <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random> <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random> <20041025162022.GA27979@work.bitmover.com> <9e47339104102511182f916705@mail.gmail.com> <20041025230128.GA1232@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-159-143.29-151.libero.it
User-Agent: MicroPlanet-Gravity/2.70.2067
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> Things we are working on include performance (Wayne has a hot cache
> linux-2.5 tree consistency check down to around 2 seconds, that's
> about a 10x improvement over what it is now), we're revamping the GUIs
> to be useable by normal humans, we're working on scaling to >500,000
> changesets in one tree, we're working on scaling the number of files and
> source to millions of files and GB of source (we just had to recompile
> with largefile support for a customer this weekend, while it worked,
> we thought the performance on a 2GB file was pathetic, it is pathetic,
> it should run at the platter speed but as I dug into I found it out
> wasn't that easy), we're working bug database integration, we're working
> on review queues, we're working on project management, we're working on
> large binary management, etc.

Ok this is probably a very stupid proposal, but since I just 
woke up I feel like saying stupid things, and plus I'm happy 
with my 512 extra RAM, so here goes:

have you considered some kind of "open source obsolete 
versions" procedure à la Aladdin? They develop GhostScript, and 
have some sort of "dual licence" strategy: the latest version 
follows the AFPL licence, and older versions are released under 
GPL.

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

