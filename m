Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280939AbRKOQzU>; Thu, 15 Nov 2001 11:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280941AbRKOQzK>; Thu, 15 Nov 2001 11:55:10 -0500
Received: from [150.146.2.236] ([150.146.2.236]:516 "EHLO
	lisa.rhpk.springfield.inwind.it") by vger.kernel.org with ESMTP
	id <S280939AbRKOQzC>; Thu, 15 Nov 2001 11:55:02 -0500
Date: Thu, 15 Nov 2001 17:48:52 +0100 (CET)
From: Cristiano Paris <c.paris@libero.it>
To: <linux-kernel@vger.kernel.org>
Subject: ramfs and inode
Message-ID: <Pine.LNX.4.33.0111151746490.405-100000@lisa.rhpk.springfield.inwind.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need an explanation, if possible.

I'm pretty sure that a VFS' inode which refers to a ramfs' file is never
released (i.e. deleted) until that is unlinked. Anyway, I cannot find a
formal verification of this assertion.

Can you help ?

Cristiano

