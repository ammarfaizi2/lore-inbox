Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbVKQBFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbVKQBFg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 20:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbVKQBFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 20:05:36 -0500
Received: from quechua.inka.de ([193.197.184.2]:1728 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1161052AbVKQBFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 20:05:35 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: virtual NICs
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <7fce76bf0511161442q5eef217dhe14f6ff1625437a2@mail.gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1EcYDT-0002A9-00@calista.inka.de>
Date: Thu, 17 Nov 2005 02:05:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <7fce76bf0511161442q5eef217dhe14f6ff1625437a2@mail.gmail.com> you wrote:
> iirc, virtual interfaces are necessary in order to configure multiple
> IP addresses using "ifconfig"

"ifconfig add" works only with v6, yes. (However this feature is easy to add
http://net-tools.berlios.de)

Note: there are some differences between alias interfaces and additional
interface addresses, because there is a primary address.

Gruss
Bernd
