Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317944AbSHHTvg>; Thu, 8 Aug 2002 15:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317950AbSHHTvf>; Thu, 8 Aug 2002 15:51:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65040 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317944AbSHHTvf>;
	Thu, 8 Aug 2002 15:51:35 -0400
Message-ID: <3D52CCA3.3050905@mandrakesoft.com>
Date: Thu, 08 Aug 2002 15:55:15 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Announce: daily 2.5 BK snapshots
References: <3D52CC12.9090909@mandrakesoft.com>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Since Linus does not do pre-patches anymore, he mentioned some time ago 
> it would be nice if somebody created an automated BK snapshot process to 
> make BK changes accessible between kernel releases.  I've done that.
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/snap/2.5/


Two more details:

* Just like a pre-patch, the Makefile EXTRAVERSION is hacked to indicate 
"-bk1", "-bk2", etc.
* I'll be setting up a process like this for 2.4, too, at the request of 
Marcelo

