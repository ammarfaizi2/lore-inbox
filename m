Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbUB2VZH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 16:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbUB2VZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 16:25:07 -0500
Received: from man-3.punkt.pl ([217.173.196.3]:9234 "EHLO prin.lo2.opole.pl")
	by vger.kernel.org with ESMTP id S262142AbUB2VZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 16:25:02 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
Date: Sun, 29 Feb 2004 22:21:41 +0100
User-Agent: KMail/1.6.1
References: <200402291942.45392.mmazur@kernel.pl> <200402292130.55743.mmazur@kernel.pl> <c1tk26$c1o$1@terminus.zytor.com>
In-Reply-To: <c1tk26$c1o$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200402292221.41977.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 of February 2004 22:03, H. Peter Anvin wrote:
> If so, we actually have a bit of an issue w.r.t. the potential
> legality of these headers.  Technically they're incompatible with LGPL
> and BSD-licensed libraries; I think we need some kind of official
> declaration that compiling against them is permitted.

/me knows nothing about legalities. So if you could explain exactly why, what 
to do about it and how can that help... (and why there wasn't any problem 
earlier, when people used headers from linux tarballs?)


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
