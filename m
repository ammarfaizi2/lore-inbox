Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130577AbRCWLCU>; Fri, 23 Mar 2001 06:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbRCWLCK>; Fri, 23 Mar 2001 06:02:10 -0500
Received: from [195.63.194.11] ([195.63.194.11]:23818 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S130532AbRCWLBz>; Fri, 23 Mar 2001 06:01:55 -0500
Message-ID: <3ABB2A19.D82B50A7@evision-ventures.com>
Date: Fri, 23 Mar 2001 11:48:57 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Stephen Clouse <stephenc@theiqgroup.com>,
        Guest section DW <dwguest@win.tue.nl>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <Pine.LNX.4.21.0103222236450.29682-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Sat, 23 Mar 2002, Martin Dalecki wrote:
> 
> > This is due to the broken calculation formula in oom_kill().
> 
> Feel free to write better-working code.

I don't get paid for it and I'm not idling through my days...
