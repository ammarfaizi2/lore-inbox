Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261984AbSKCOsA>; Sun, 3 Nov 2002 09:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSKCOsA>; Sun, 3 Nov 2002 09:48:00 -0500
Received: from [198.149.18.6] ([198.149.18.6]:25989 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261984AbSKCOr7>;
	Sun, 3 Nov 2002 09:47:59 -0500
Subject: Re: [2.5.45] Unable to umount XFS filesystems
From: Stephen Lord <lord@sgi.com>
To: kronos@kronoz.cjb.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021102151320.GA308@dreamland.darkstar.net>
References: <20021102151320.GA308@dreamland.darkstar.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 03 Nov 2002 08:49:01 -0600
Message-Id: <1036334944.1061.87.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-02 at 09:13, Kronos wrote:
> Hi,
> with kernel  2.5.45 I'm  unable to unmount  XFS filesystems. 'umount' is
> blocked in D state:

Yes, I have had the same thing happen, and so far have not had time to
dig into it. It happens without preempt turned on too. Hope to have a
chance to look at this early in the week. Thanks for the traces though.

Steve


