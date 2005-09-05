Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVIEDvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVIEDvV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 23:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVIEDvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 23:51:21 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:6291 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932184AbVIEDvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 23:51:20 -0400
Message-ID: <35547.10.10.10.10.1125892279.squirrel@linux1>
In-Reply-To: <20050905034158.97152.qmail@web50213.mail.yahoo.com>
References: <36918.10.10.10.10.1125889201.squirrel@linux1>
    <20050905034158.97152.qmail@web50213.mail.yahoo.com>
Date: Sun, 4 Sep 2005 23:51:19 -0400 (EDT)
Subject: re: RFC: i386: kill !4KSTACKS
From: "Sean" <seanlkml@sympatico.ca>
To: "Alex Davis" <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, September 4, 2005 11:41 pm, Alex Davis said:

> It will never be 'appropriate' if the system doesn't somehow work on Joe's
> hardware. We currently have something that works. In my opinion it's
> pointless to take that away. The manufacturers will still stone-wall us
> regardless of ndiswrapper's existence. They were doing it before ndis-
> wrapper existed.

There are lots and lots of systems where Linux works.  Encouraging users
to buy hardware that works with Linux, can only help.  Encouraging them
that it doesn't matter and that binary-only drivers are a good
alternative, can only hurt.

> Please explain how Linux can be an 'important force' if people can't
> use it? Wireless networking is very important to people.

Lots of people can and do use Linux without ANY binary drivers.   There
are Wireless choices that don't require binary only drivers.

> Um, ever hear of 'compromise'?? All I'm saying is let people use what
> currently works until we can get an open-source solution. Ndiswrapper's
> existence is not stopping you (or anyone else) from pestering
> manufacturers
> for spec's and writing drivers. I look at ndiswrapper as a stop-gap
> solution.
> Hey, even Linus himself has said 'better a sub-optimal solution than no
> solution'.

Nobody is stopping anyone from using what "currently works", there will be
lots of like minded people to provide crap kernels and shitty binary
drivers to people who don't know better.   So don't worry, your well
intentioned vision of the future will survive the removal of 8K stacks
from the kernel.

Regards,
Sean


