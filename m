Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262036AbRERBCX>; Thu, 17 May 2001 21:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262221AbRERBCE>; Thu, 17 May 2001 21:02:04 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:16768 "EHLO
	think.thunk.org") by vger.kernel.org with ESMTP id <S262036AbRERBB6>;
	Thu, 17 May 2001 21:01:58 -0400
Date: Wed, 16 May 2001 19:12:06 -0400
From: Theodore Tso <tytso@valinux.com>
To: Val Henson <val@nmt.edu>
Cc: Stuart MacDonald <stuartm@connecttech.com>,
        Theodore Tso <tytso@valinux.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] drivers/char/serial.c bug in ST16C654 detection
Message-ID: <20010516191206.B857@think.thunk.org>
Mail-Followup-To: Theodore Tso <tytso@valinux.com>,
	Val Henson <val@nmt.edu>,
	Stuart MacDonald <stuartm@connecttech.com>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20010511182723.M18959@boardwalk> <033101c0dcaf$10557f40$294b82ce@connecttech.com> <20010514162010.G5060@boardwalk> <010001c0dd46$38fc9360$294b82ce@connecttech.com> <20010516161245.O6892@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010516161245.O6892@boardwalk>; from val@nmt.edu on Wed, May 16, 2001 at 04:12:45PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 04:12:45PM -0600, Val Henson wrote:
> Anyone know where Ted Tso is?  He hasn't posted in several weeks.
> Alan, will you put this in -ac?  This patch fixes a bug in serial.c
> that causes a crash on machines with a ST16C654.

I'm around, just swamped with a few other things.  Dealing with serial
driver issues is on the top of my to do list....

						- Ted
