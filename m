Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbTIDQfh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbTIDQfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:35:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:46998 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265218AbTIDQdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:33:44 -0400
Date: Thu, 4 Sep 2003 09:33:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthias Andree <matthias.andree@gmx.de>
cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>,
       <marcelo.tosatti@cyclades.com.br>, <samel@mail.cz>
Subject: Re: BK-kernel-tools/shortlog update
In-Reply-To: <20030904160911.GA6694@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.44.0309040932000.1665-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Sep 2003, Matthias Andree wrote:
> 
> I'm reluctant to drop addresses. Someone might want to format older log
> entries; considering that the software isn't usually up to date when
> Marcelo releases a kernel (Linus seems to care, Marcelo doesn't ever add
> data or request adding data - maybe I should ask him), that's where we
> stand.

I agree. We shouldn't drop name translations: right now "shortlog" is the 
_only_ place where we hold the things.

In fact, I'd love to somebody to do a shortlog of the entire 2.5.x kernel
repository, just to make sure that we have everybody.

		Linus

