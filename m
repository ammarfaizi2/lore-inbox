Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbTGIW74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 18:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268703AbTGIW74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 18:59:56 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:10980 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S268702AbTGIW7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 18:59:51 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Davide Libenzi <davidel@xmailserver.org>,
       Jamie Lokier <jamie@shareable.org>
Subject: Re: 2.5.74-mm1
Date: Thu, 10 Jul 2003 01:15:46 +0200
User-Agent: KMail/1.5.2
Cc: Mel Gorman <mel@csn.ul.ie>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
References: <20030703023714.55d13934.akpm@osdl.org> <20030709222426.GA24923@mail.jlokier.co.uk> <Pine.LNX.4.55.0307091524240.4625@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0307091524240.4625@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307100115.46478.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 July 2003 00:29, Davide Libenzi wrote:
> On Wed, 9 Jul 2003, Jamie Lokier wrote:
> > Indeed.  But maybe true (bounded CPU) realtime, reliable, would more
> > accurately reflect what the user actually wants for some apps?
>
> Hopefully I'll have a couple of hours free to code and test the
> SCHED_SOFTRR idea ;) It's hard to push for a new POSIX definition though :)

Oops, sorry for attributing that to Jamie instead of you :-/

Regards,

Daniel

