Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130047AbRBSO4P>; Mon, 19 Feb 2001 09:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130278AbRBSO4F>; Mon, 19 Feb 2001 09:56:05 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:10051 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S130047AbRBSOzw>; Mon, 19 Feb 2001 09:55:52 -0500
Date: Mon, 19 Feb 2001 08:55:28 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: David Howells <dhowells@cambridge.redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [LONG RANT] Re: Linux stifles innovation... 
In-Reply-To: <24970.982591637@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.3.96.1010219085405.17842F-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, David Howells wrote:
> I suspect part of the problem with commercial driver support on Linux is that
> the Linux driver API (such as it is) is relatively poorly documented

In-kernel documentation, agreed.

_Linux Device Drivers_ is a good reference for 2.2 and below.

> and seems
> to change almost on a week-by-week basis anyway. I've done my share of chasing
> the current kernel revision with drivers that aren't part of the kernel tree:
> by the time you update the driver to work with the current kernel revision,
> there's a new one out, and the driver doesn't compile with it.

This is entirely in your imagination.  Driver APIs are stable across the
stable series of kernels: 2.0.0 through 2.0.38, 2.2.0 through 2.2.18,
2.4.0 through whatever.

	Jeff





