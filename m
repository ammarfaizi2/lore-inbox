Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTGKVT1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTGKVT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:19:26 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:48120 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261151AbTGKVT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:19:26 -0400
Message-Id: <200307112134.h6BLY7Fg004873@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Linux 2.5.75
To: linux-kernel@vger.kernel.org
Date: Fri, 11 Jul 2003 23:33:40 +0200
References: <7TEe.Bz.21@gated-at.bofh.it> <7TNS.Kc.9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>> 
>> No ppc, ppc64, s390?
> 
> Do we have distributions that intend to make releases using those? I
> suspect not, but hey, don't get me wrong: I'd love to see them working
> out-of-the-box.

At the moment, the s390 port is fully merged and functional (~30 known bugs,
more to be found) in the your tree, something that has never been the
case in 2.2 or 2.4.

I expect to see an official debian kernel for s390 2.6.early without any
architecture specific patches. The commercial distributions are likely
to remain some more time on 2.4.{19,21}, actually there are probably more
people still running 2.4.7 than 2.4.19 on s390...

        Arnd <><
