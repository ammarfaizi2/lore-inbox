Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131821AbRCOT5n>; Thu, 15 Mar 2001 14:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131822AbRCOT5d>; Thu, 15 Mar 2001 14:57:33 -0500
Received: from datafoundation.com ([209.150.125.194]:45842 "EHLO
	datafoundation.com") by vger.kernel.org with ESMTP
	id <S131821AbRCOT5T>; Thu, 15 Mar 2001 14:57:19 -0500
Date: Thu, 15 Mar 2001 14:56:19 -0500 (EST)
From: John Jasen <jjasen@datafoundation.com>
To: Ted Gervais <ve1drg@ve1drg.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.2
In-Reply-To: <Pine.LNX.4.21.0103151527420.2382-100000@ve1drg.com>
Message-ID: <Pine.LNX.4.30.0103151455350.343-100000@flash.datafoundation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Ted Gervais wrote:

> Anyways - to get things to work, I have put added this statement to the
> top of my /etc/rc.d/rc.inet1 file:
>
> insmod /usr/src/linux/drivers/net/8139too.o.

install a later version of modutils, as the /lib/modules directory tree
has changed between 2.2.x and 2.4.x



