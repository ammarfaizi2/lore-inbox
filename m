Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317624AbSIJP0K>; Tue, 10 Sep 2002 11:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319152AbSIJP0K>; Tue, 10 Sep 2002 11:26:10 -0400
Received: from packet.digeo.com ([12.110.80.53]:5614 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S317624AbSIJP0J>;
	Tue, 10 Sep 2002 11:26:09 -0400
Message-ID: <3D7E13B1.35916118@digeo.com>
Date: Tue, 10 Sep 2002 08:45:53 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.34 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marc-Christian Petersen <m.c.p@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.xx and ext3
References: <200209101423.37000.m.c.p@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Sep 2002 15:30:48.0227 (UTC) FILETIME=[09A0A730:01C258DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen wrote:
> 
> Hi there,
> 
> say, is there any good reason for 2.5.xx ext3 to be version 0.9.16 and not
> 0.9.18 + additional patches from akpm?
> 

I forget to update the version string.  The version doesn't mean much now
the fs is in-kernel.  2.5 ext3 is pretty much up to date - I just need to
go through and double-check that.
