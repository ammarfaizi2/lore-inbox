Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbUAHBiU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 20:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUAHBiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 20:38:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:49031 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263310AbUAHBiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 20:38:19 -0500
Date: Wed, 7 Jan 2004 17:38:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>,
       Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
In-Reply-To: <20040107192434.GA823@kroah.com>
Message-ID: <Pine.LNX.4.58.0401071736560.12602@home.osdl.org>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com>
 <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107185656.GB31827@kroah.com>
 <3FFC5CBB.5050507@kolumbus.fi> <20040107192434.GA823@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Jan 2004, Greg KH wrote:
> 
> If accessing the partition doesn't work, than having udev create all
> partitions wouldn't help anything :(

Accessing a partition should definitely work. I regularly just stick in a 
memory card in a card reader and directly access sda1.

		Linus
