Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261949AbTCVX3h>; Sat, 22 Mar 2003 18:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbTCVX3h>; Sat, 22 Mar 2003 18:29:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42184 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261949AbTCVX3g>;
	Sat, 22 Mar 2003 18:29:36 -0500
Message-ID: <3E7CF48F.9070204@pobox.com>
Date: Sat, 22 Mar 2003 18:41:03 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.65-ac3
References: <200303222050.h2MKopw28918@devserv.devel.redhat.com>
In-Reply-To: <200303222050.h2MKopw28918@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Linux 2.5.65-ac3
> o	Revert some dead fb stuff I missed		(me)
> o	Fix eisa printk for 0 devices			(me)
> o	Resync with Linus bk3
> 	- Drop broken tty changes in Linus tree
> o	Implement tty changes properly			(me)


tty fixes... yum!

Once your tty and ide bits are merged, what's left on the plate (in your 
opinion) before 2.6.0-test1?

	Jeff



