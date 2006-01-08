Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWAHHSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWAHHSn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 02:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWAHHSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 02:18:43 -0500
Received: from quechua.inka.de ([193.197.184.2]:22147 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932199AbWAHHSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 02:18:42 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <d9def9db0601072258v39ac4334kccc843838b436bba@mail.gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1EvUp6-0008Ni-00@calista.inka.de>
Date: Sun, 08 Jan 2006 08:18:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Rechberger <mrechberger@gmail.com> wrote:
> Hi,
> 
> what does hdparm show up?
> Were there any other processes running during the test?
> what does "vmstat 1" show up during the test?

also also retry with redirection to /dev/null, this could be a console
problem since there is 5 minutes wait time.

Gruss
Bernd
