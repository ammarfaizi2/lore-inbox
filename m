Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262974AbTC1NmJ>; Fri, 28 Mar 2003 08:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262977AbTC1NmJ>; Fri, 28 Mar 2003 08:42:09 -0500
Received: from rakis.net ([216.235.252.212]:32708 "EHLO egg.rakis.net")
	by vger.kernel.org with ESMTP id <S262974AbTC1NmI>;
	Fri, 28 Mar 2003 08:42:08 -0500
Date: Fri, 28 Mar 2003 08:53:14 -0500 (EST)
From: Greg Boyce <gboyce@rakis.net>
X-X-Sender: gboyce@egg
To: linux-kernel@vger.kernel.org
Subject: Panic using wireless on 2.5.66-mm1
Message-ID: <Pine.LNX.4.42.0303280847200.8585-100000@egg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I was playing with 2.5.66-mm1, and I noticed that my wireless card was not
working on bootup (Orinoco card).  This card has worked fine in 2.5.65 and
in various other -mm series kernels.

I attempted to to restart pcmcia, and it resulted in a panic.  I'm
attaching a copy of dmesg and the .config file I used to compile the
kernel.  If there's anything else you need, please let me know.

-- Greg Boyce

