Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261810AbREUHtC>; Mon, 21 May 2001 03:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261823AbREUHsx>; Mon, 21 May 2001 03:48:53 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:7438 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261810AbREUHsn>; Mon, 21 May 2001 03:48:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Ben LaHaise <bcrl@redhat.com>, <torvalds@transmeta.com>
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code in userspace
Date: Sat, 19 May 2001 15:53:03 +0200
X-Mailer: KMail [version 1.2]
Cc: <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0105190138150.6079-100000@toomuch.toronto.redhat.com>
In-Reply-To: <Pine.LNX.4.33.0105190138150.6079-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Message-Id: <01051915530307.00491@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 May 2001 08:23, Ben LaHaise wrote:
>  /dev/sda/offset=1024,limit=2048
>                 -> open a device that gives a view of sda at an
>                       offset of 1KB to 2KB

Whatever we end up with, can we express it in terms of base, size,
please?

--
Daniel
