Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261627AbSJGSZ4>; Mon, 7 Oct 2002 14:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262517AbSJGSZz>; Mon, 7 Oct 2002 14:25:55 -0400
Received: from dsl-213-023-021-129.arcor-ip.net ([213.23.21.129]:65194 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261627AbSJGSZS>;
	Mon, 7 Oct 2002 14:25:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jesse Pollard <pollard@admin.navo.hpc.mil>,
       Rob Landley <landley@trommello.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Date: Mon, 7 Oct 2002 20:22:41 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <200210060130.g961UjY2206214@pimout2-ext.prodigy.net> <200210070856.07356.pollard@admin.navo.hpc.mil>
In-Reply-To: <200210070856.07356.pollard@admin.navo.hpc.mil>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ycWf-0003u4-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 October 2002 15:56, Jesse Pollard wrote:
> [the mouse] will still stall everytime the mouse crosses the window border IF the
> application has specified "enter/leave" event notification. This requires the
> application to be swapped in to recieve the event. The only fix is locking
> the application/X libraries into memory.

That one could be punted with an hourglass cursor, until the events start flowing.
Well.  Not sure how much this has to do with the kernel...

-- 
Daniel
