Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263400AbTHWUwG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 16:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263351AbTHWUwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 16:52:06 -0400
Received: from [213.4.129.129] ([213.4.129.129]:53431 "EHLO tsmtp10.mail.isp")
	by vger.kernel.org with ESMTP id S263418AbTHWUul convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 16:50:41 -0400
Date: Sat, 23 Aug 2003 22:42:55 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Arno Wagner <wagner@tik.ee.ethz.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.6.0-test3: dmesg buffer still too small
Message-Id: <20030823224255.34fee3a0.diegocg@teleline.es>
In-Reply-To: <20030823151336.GB4266@tik.ee.ethz.ch>
References: <20030823151336.GB4266@tik.ee.ethz.ch>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 23 Aug 2003 17:13:36 +0200 Arno Wagner <wagner@tik.ee.ethz.ch> escribió:

> b) Add a configuration option to set the buffer size
>    in kernel configuration.
> 
  (15) Kernel log buffer size (16 => 64KB, 17 => 128KB


Under "general setup" at least in -test3/4
