Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbULBGVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbULBGVg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 01:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbULBGVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 01:21:35 -0500
Received: from quechua.inka.de ([193.197.184.2]:36518 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261561AbULBGVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 01:21:31 -0500
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: How to understand flow of kernel code
Organization: Deban GNU/Linux Homesite
In-Reply-To: <41AE9E3E.9020307@globaledgesoft.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CZkLJ-0006Ku-00@calista.eckenfels.6bone.ka-ip.net>
Date: Thu, 02 Dec 2004 07:21:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <41AE9E3E.9020307@globaledgesoft.com> you wrote:
> Can Anyone tell me the tips/tricks/techniques/practices followed in 
> understanding flow of Linux kernel code?

You read the code and use an ide which allows to find declarations/usage
(ctags suppot in editor for eample). You could also browse with LXR. But
some basic architectural understanding from various kernel books and
articles is helpfull.

http://lxr.linux.no/source/init/main.c

Greetings
Bernd
