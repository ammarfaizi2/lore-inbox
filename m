Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318081AbSGXW7G>; Wed, 24 Jul 2002 18:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318088AbSGXW7G>; Wed, 24 Jul 2002 18:59:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27910 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318081AbSGXW7G>; Wed, 24 Jul 2002 18:59:06 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux-2.5.28
Date: Wed, 24 Jul 2002 23:02:21 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <ahnblt$1jb$1@penguin.transmeta.com>
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com> <20020724234344.I25115@flint.arm.linux.org.uk>
X-Trace: palladium.transmeta.com 1027551727 17034 127.0.0.1 (24 Jul 2002 23:02:07 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 24 Jul 2002 23:02:07 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020724234344.I25115@flint.arm.linux.org.uk>,
Russell King  <rmk@arm.linux.org.uk> wrote:
>
>I'd just like to clear up some confusion here.
>
>Under this cset is a change that adds '-g' to the top-level make flags.

Oops, you're right. I'll undo that, and sorry for the attribution mess.

		Linus
