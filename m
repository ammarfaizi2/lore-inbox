Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVDJBOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVDJBOL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 21:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVDJBOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 21:14:11 -0400
Received: from quechua.inka.de ([193.197.184.2]:39388 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261174AbVDJBOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 21:14:09 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20050409173944.247252eb.pj@engr.sgi.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DKR1Y-0006nd-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 10 Apr 2005 03:14:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050409173944.247252eb.pj@engr.sgi.com> you wrote:
> Ralph wrote:
>> Watch out for when xargs invokes do_something more than once and the `<'
>> is parsed by a different one than the `>'.
> It will take a pretty long list to do that.  It seems that
> GNU xargs on top of a Linux kernel has a 128 KByte ARG_MAX.
> In the old days, with 4 KByte ARG_MAX limits, this would have
> bitten us pretty quickly.

Nevertheless I  think it is more parser friendly to have single records for
diffs.

Greetings
Bernd
