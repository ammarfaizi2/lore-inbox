Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWDOTyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWDOTyh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 15:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWDOTyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 15:54:37 -0400
Received: from mgw-ext13.nokia.com ([131.228.20.172]:26007 "EHLO
	mgw-ext13.nokia.com") by vger.kernel.org with ESMTP
	id S1751388AbWDOTyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 15:54:36 -0400
Date: Sat, 15 Apr 2006 22:35:33 +0300 (EEST)
From: Samuel Ortiz <samuel.ortiz@nokia.com>
X-X-Sender: samuel@irie
Reply-To: samuel.ortiz@nokia.com
To: "ext David S. Miller" <davem@davemloft.net>
cc: bunk@stusta.de, ext Jean Tourrilhes <jt@hpl.hp.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] net/irda/irias_object.c: remove unused exports
In-Reply-To: <20060415.022702.120267858.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0604152235001.1212@irie>
References: <20060414114446.GL4162@stusta.de> <Pine.LNX.4.58.0604151157320.1032@irie>
 <20060415.022702.120267858.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Apr 2006 19:35:33.0372 (UTC) FILETIME=[C309B3C0:01C660C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Apr 2006, ext David S. Miller wrote:

> From: Samuel Ortiz <samuel.ortiz@nokia.com>
> Date: Sat, 15 Apr 2006 11:58:21 +0300 (EEST)
>
> > On Fri, 14 Apr 2006, ext Adrian Bunk wrote:
> >
> > > This patch removes the following unused EXPORT_SYMBOL's:
> > > - irias_find_attrib
> > > - irias_new_string_value
> > > - irias_new_octseq_value
> > >
> > > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > Looks good to me.
> >
> > Signed-off-by: Samuel Ortiz <samuel.ortiz@nokia.com>
>
> Sam, just add this to your IRDA queue.  Ok?
Sure, I will.
