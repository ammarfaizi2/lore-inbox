Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269871AbTGOXA3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 19:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269878AbTGOXA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 19:00:28 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:6380 "EHLO
	oden.fish.net") by vger.kernel.org with ESMTP id S269871AbTGOXAY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 19:00:24 -0400
Date: Wed, 16 Jul 2003 01:16:04 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE performance problems on 2.6.0-pre1
Message-Id: <20030716011604.03987c0e.lista1@telia.com>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2003-07-15 22:27:19 derek wrote:

> hdparm -a 512 on the other hand...
> Timing buffered disk reads:  140 MB in  3.03 seconds =  46.18 MB/sec
> and I get my previous numbers back.

Ahhh thank you derek! I followed your example and got _my_ old numbers
back, from 22 to 28 MB/sec. Surely this is a bUg. Been there for a long
time.

Mvh
Mats Johannesson
