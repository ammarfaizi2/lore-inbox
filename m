Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288834AbSA2Gmd>; Tue, 29 Jan 2002 01:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288854AbSA2GmX>; Tue, 29 Jan 2002 01:42:23 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:2445 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S288834AbSA2GmP>; Tue, 29 Jan 2002 01:42:15 -0500
Date: Tue, 29 Jan 2002 08:37:06 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2 fs corruption and usb devices
In-Reply-To: <3C558BC0.5050700@wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0201290831360.20095-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Pierre Rousselet wrote:

> Where have you seen it's an oops. have you read my message ?

oops, i wasn't paying too much attention in that mail run it seems

> Why? The problem is solved by the diff in ext2 code in 2.4.18-pre7
> (have you read my message ?)

I got that the first time...

> What i would like to know is why the corruption of the ext2 root fs with 
>   2.4.18-pre6 in only visible by the usb drivers. is it pure chance ?

But i still think proprietory modules showing up in problem traces is 
usually enough to warrant the trace as useless. The fact that it works now 
and not then could be anybody's guess.

My apologies for skimming through your email, Have a nice day.

Zwane Mwaikambo


