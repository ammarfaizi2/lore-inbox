Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261598AbSJFMnP>; Sun, 6 Oct 2002 08:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263390AbSJFMnP>; Sun, 6 Oct 2002 08:43:15 -0400
Received: from server0027.freedom2surf.net ([194.106.33.36]:18907 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S261598AbSJFMnO>; Sun, 6 Oct 2002 08:43:14 -0400
Date: Sun, 6 Oct 2002 14:02:02 +0100
From: Ian Molton <spyro@f2s.com>
To: Gigi Duru <giduru@yahoo.com>
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-Id: <20021006140202.45cb9100.spyro@f2s.com>
In-Reply-To: <20021005205238.47023.qmail@web13201.mail.yahoo.com>
References: <Pine.LNX.4.10.10210051252130.21833-100000@master.linux-ide.org>
	<20021005205238.47023.qmail@web13201.mail.yahoo.com>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.8.3cvs4 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2002 13:52:38 -0700 (PDT)
Gigi Duru <giduru@yahoo.com> wrote:

> 
> Now thats some advice from a kernel hacker... You
> really don't seem to care too much about embedded, do
> you? 

I do. I have to. Im porting the Linux kernel to the arm26 architecture
(repairing the long dead port by Russell King).

Even on these tiny, 15 year old machines, the kernel will EASILY fit
into their ROMs, with bags of room to spare.

The biggest machine EVER of this type has only 16 MB of RAM. most have
2-4MB. Some even have MFM harddiscs.
