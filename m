Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261843AbREUHtC>; Mon, 21 May 2001 03:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261810AbREUHsx>; Mon, 21 May 2001 03:48:53 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:4622 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261805AbREUHsi>; Mon, 21 May 2001 03:48:38 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: Negative inode-nr ?
Date: Sat, 19 May 2001 22:04:28 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0105191332150.5531-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.21.0105191332150.5531-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Message-Id: <01051922042809.00491@starship>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 May 2001 18:33, Rik van Riel wrote:
> On Sat, 19 May 2001, [iso-8859-1] Jakob Østergaard wrote:
> > What do you think of this ?
> > [root]# cat /proc/sys/fs/inode-nr
> > 157097	-180
>
> I think you should upgrade to a newer kernel; Al Viro
> fixed this bug and the fix went into 2.4.5-pre1.

What was the bug and how was it fixed?

/me wishes one more time for an applied-patch history.

--
Daniel
