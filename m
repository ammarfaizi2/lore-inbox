Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263411AbTHXBNT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 21:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263406AbTHXBNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 21:13:19 -0400
Received: from smtp.terra.es ([213.4.129.129]:31463 "EHLO tsmtp8.mail.isp")
	by vger.kernel.org with ESMTP id S263411AbTHXBNS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 21:13:18 -0400
Date: Sun, 24 Aug 2003 03:12:35 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Arno Wagner <wagner@tik.ee.ethz.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.6.0-test3: dmesg buffer still too small
Message-Id: <20030824031235.1780c622.diegocg@teleline.es>
In-Reply-To: <20030824010539.GA5682@tik.ee.ethz.ch>
References: <20030823151336.GB4266@tik.ee.ethz.ch>
	<20030823224255.34fee3a0.diegocg@teleline.es>
	<20030824010539.GA5682@tik.ee.ethz.ch>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 24 Aug 2003 03:05:39 +0200 Arno Wagner <wagner@tik.ee.ethz.ch> escribió:

> Not displayed by "make menuconfig" and "make config" 
> unfortunately.

I just copied it from menuconfig. Visible if you've enabled DEBUG_KERNEL.

