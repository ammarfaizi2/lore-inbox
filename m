Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131483AbRDJLgZ>; Tue, 10 Apr 2001 07:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131484AbRDJLgP>; Tue, 10 Apr 2001 07:36:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:32977 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131483AbRDJLgK>;
	Tue, 10 Apr 2001 07:36:10 -0400
Date: Tue, 10 Apr 2001 07:36:09 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: kees <kees@schoen.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] exec_via_sudo
In-Reply-To: <Pine.LNX.4.21.0104101251210.6726-100000@schoen3.schoen.nl>
Message-ID: <Pine.GSO.4.21.0104100735320.12101-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Apr 2001, kees wrote:

> Hi
> 
> Unix/Linux have a lot of daemons that have to run as root because they
> need to acces some specific data or run special programs. They are
> vulnerable as we learn.
> Is there any way to have something like an exec call that is
> subject to a sudo like permission system? That would run the daemons
> as a normal user but allow only for specific functions i.e. NOT A SHELL.
> comments?

Thou shalt not put policy into the kernel.

