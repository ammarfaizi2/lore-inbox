Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130051AbRBBFWN>; Fri, 2 Feb 2001 00:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130428AbRBBFWD>; Fri, 2 Feb 2001 00:22:03 -0500
Received: from [206.112.107.150] ([206.112.107.150]:59911 "EHLO
	mercury.illtel.denver.co.us") by vger.kernel.org with ESMTP
	id <S130364AbRBBFVs>; Fri, 2 Feb 2001 00:21:48 -0500
Date: Thu, 1 Feb 2001 21:22:32 -0800 (PST)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
To: Joe deBlaquiere <jadb@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Serial device with very large buffer
In-Reply-To: <3A7A3E14.1010300@redhat.com>
Message-ID: <Pine.LNX.4.10.10102012111140.991-100000@mercury>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Joe deBlaquiere wrote:

> Hi Alex!
> 
> 	I'm a little confused here... why are we overrunning? This thing is 
> running externally at 19200 at best, even if it does all come in as a 
> packet.

  Different Merlin -- original Merlin is 19200, "Merlin for Ricochet" is
128Kbps (or faster), and uses Metricom/Ricochet network.

-- 
Alex

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
