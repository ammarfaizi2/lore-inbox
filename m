Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTIQWkn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 18:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbTIQWkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 18:40:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:46465 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262874AbTIQWkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 18:40:42 -0400
Date: Wed, 17 Sep 2003 15:21:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: jbarnes@sgi.com (Jesse Barnes)
Cc: pfg@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Altix console driver
Message-Id: <20030917152139.42a1ce20.akpm@osdl.org>
In-Reply-To: <20030917222414.GA25931@sgi.com>
References: <20030917222414.GA25931@sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbarnes@sgi.com (Jesse Barnes) wrote:
>
> Just a simple addition to drivers/char for the Altix serial console.
> 
>  MAINTAINERS              |    6 
>  drivers/char/Kconfig     |   16 
>  drivers/char/Makefile    |    1 
>  drivers/char/sn_serial.c | 1189 +++++++++++++++++++++++++++++++++++++++++++++++

Would it be more appropriate to place this under arch/ia64?


