Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbULLW7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbULLW7G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 17:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbULLW7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 17:59:06 -0500
Received: from quechua.inka.de ([193.197.184.2]:37329 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262162AbULLW7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 17:59:03 -0500
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [WISHLIST] IBM HD Shock detection in Linux
Organization: Deban GNU/Linux Homesite
In-Reply-To: <1102888882.15558.2.camel@ksyrium.local>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CdcgA-0002Qy-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 12 Dec 2004 23:59:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1102888882.15558.2.camel@ksyrium.local> you wrote:
> The code apparently can display the horizon, but cannot prevent
> shocks :(

This code is not helpfull since it uses a win32 ioctl. One would have to
know what this ioctl is doing with the disk. Personally I think it is either
using smart or its an april fools joke.

Greetings
Bernd
