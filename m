Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbTCFP0o>; Thu, 6 Mar 2003 10:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267528AbTCFP0o>; Thu, 6 Mar 2003 10:26:44 -0500
Received: from air-2.osdl.org ([65.172.181.6]:22506 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266615AbTCFP0f>;
	Thu, 6 Mar 2003 10:26:35 -0500
Date: Thu, 6 Mar 2003 09:13:07 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: CaT <cat@zip.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Failed to register 'sysfs' in sysfs?
In-Reply-To: <20030306133240.GD464@zip.com.au>
Message-ID: <Pine.LNX.4.33.0303060912260.994-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Mar 2003, CaT wrote:

> Saw that in my dmesg. What does it mean? Do I have something configured
> incorrectly? I tried doing a search of the mailing list but found
> nothing. A search of the web also revealing nothing as did a look at
> Documentation/filesystems/sysfs.txt.

It's an erroneous message. There is a patch in Linus's tree to quiet it 
already, so please ignore it. 

	-pat

