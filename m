Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265256AbUETTLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUETTLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 15:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265257AbUETTLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 15:11:41 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:11757 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S265256AbUETTLk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 15:11:40 -0400
Subject: Sluggish performances with FreeBSD
From: Laurent Goujon <laurent.goujon@online.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1085080302.7764.20.camel@caribou.no-ip.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7-2mdk 
Date: Thu, 20 May 2004 21:11:42 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Currently I have a two computers : 
- The first one is my gateway. It's running Freebsd 5.2 stable, has two
networks cards, a realtek 8139 and a broadcom 4401
- The second one is my laptop and it's running most of the time Linux
(Mandrake cooker with a 2.6.6 kernel), sometimes winxp (because of the
lack of support for some hardware components) and has a sis900 network
adapter

My problem is :
I have very poor performances with tcp streams from my server to my
laptop (0.35 Mb/s), but throughput is normal from the laptop to the
server (90Mb/s) and also (my favorite one) from Internet to my laptop
(~4Mb/s).
When I'm running WinXP, all is quite normal.

I've tried to invert network cards on my server, to bypass my switch :
no result

Any idea ?

Laurent Goujon


