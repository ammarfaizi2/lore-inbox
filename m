Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265828AbSL3UEj>; Mon, 30 Dec 2002 15:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265830AbSL3UEj>; Mon, 30 Dec 2002 15:04:39 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:28341 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S265828AbSL3UEg>;
	Mon, 30 Dec 2002 15:04:36 -0500
Date: Mon, 30 Dec 2002 21:12:46 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Juan Gomez <juang@us.ibm.com>
Cc: Shaya Potter <spotter@cs.columbia.edu>, linux-kernel@vger.kernel.org
Subject: Re: nfsservctl documentation?
Message-ID: <20021230201246.GA16350@win.tue.nl>
References: <OF0BDEC488.45CFEF00-ON87256C9F.0065D913@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF0BDEC488.45CFEF00-ON87256C9F.0065D913@us.ibm.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> is there any real documentation on the nfsservctl syscall anywhere?
>> I can't find any documentation besides the skimpy man page

> Well you have the best documentation of all: the code itself. I did not
> find anything else other than the man page when trying to undestand it but
> the code was easy to follow.

Improvements on this man page (or any man page) are always welcome.

[OT]
Yesterday, or this morning or so, man-pages-1.54.tar.gz was released.
(E.g. at ftp://ftp.win.tue.nl/pub/linux-local/manpages/ )
A new page is tty_ioctl.4.
Maybe some people would like to check details, point out undocumented
tty ioctls, or add fragments.
Of course, we need many more pages foo_ioctl.4.

Andries - aeb@cwi.nl
