Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318251AbSGRQgc>; Thu, 18 Jul 2002 12:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318263AbSGRQgb>; Thu, 18 Jul 2002 12:36:31 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:11262 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318251AbSGRQgb>; Thu, 18 Jul 2002 12:36:31 -0400
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
From: Robert Love <rml@tech9.net>
To: Guillaume Boissiere <boissiere@adiglobal.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D361091.13618.16DC46FB@localhost>
References: <3D361091.13618.16DC46FB@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Jul 2002 09:39:30 -0700
Message-Id: <1027010370.1555.113.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-17 at 21:49, Guillaume Boissiere wrote:

> o Strict address space accounting                 (Alan Cox)

My patch for this, while a bit large, is simple enough it can be merged
after the freeze.  E.g., if rmap is merged this is just "more rmap work"
and sane.

I would bump this down to "After feature freeze..." although I see no
reason it cannot go in sooner (I just do not consider it a pre-freeze
item in terms of its impact).

> After feature freeze:

Easily 90% of this stuff should _not_ go in after the freeze.  It either
needs to make it in now or hold its breath until 2.7.

I would much prefer a rush of merges now and less "improper" merges
after the freeze.  In fact, I do not care much what we do now as long as
we treat the freeze as a freeze and work solely to stabilize stuff.

	Robert Love

