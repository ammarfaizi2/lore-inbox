Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312574AbSDATvM>; Mon, 1 Apr 2002 14:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312579AbSDATvD>; Mon, 1 Apr 2002 14:51:03 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:43699 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312576AbSDATuu>;
	Mon, 1 Apr 2002 14:50:50 -0500
Date: Mon, 1 Apr 2002 14:50:47 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Max <ertzog@bk.ru>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Syscall by name
In-Reply-To: <20020324213118.GA14590@bk.ru>
Message-ID: <Pine.GSO.4.21.0204011449560.10933-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Mar 2002, Max wrote:

> I saw several months ago here a message, telling about a new system call,
> that returnes a syscall number, by its name. So, if a module registers a
> new syscall dynamically, it is automatically seen by everybody.
> Is this idea dead?

It's stillborn - modules are not (and will not be) allowed to add syscalls.
Case closed.

