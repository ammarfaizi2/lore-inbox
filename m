Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266004AbUFOW65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUFOW65 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 18:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUFOW65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 18:58:57 -0400
Received: from quechua.inka.de ([193.197.184.2]:21382 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S266004AbUFOW64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 18:58:56 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Bug#253590: How to turn off IPV6 (link local)
Organization: Deban GNU/Linux Homesite
In-Reply-To: <1087334878.1689.1.camel@teapot.felipe-alfaro.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BaMtL-0003Bs-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 16 Jun 2004 00:58:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1087334878.1689.1.camel@teapot.felipe-alfaro.com> you wrote:
> 3ff8 a link local address? I think you're wrong. Link local addresses
> have the fe80:: prefix. 3ff8::/64 is a global unicast IPv6 address.

Yes indeed, this was an cut+paste error, the other places in the text
correctly refer to fe80::/64.

I moved the discussion to linux-net@vger.

Gruss
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
