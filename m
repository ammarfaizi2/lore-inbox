Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbRCCWki>; Sat, 3 Mar 2001 17:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129833AbRCCWk1>; Sat, 3 Mar 2001 17:40:27 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:32782 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S129830AbRCCWkQ>; Sat, 3 Mar 2001 17:40:16 -0500
Date: Sat, 3 Mar 2001 14:40:15 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Christopher Friesen <cfriesen@nortelnetworks.com>,
        John Being <olonho@hotmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: strange nonmonotonic behavior of gettimeoftheday -- seen similar
          problem on PPC
In-Reply-To: <Pine.LNX.3.95.1010302103506.1920A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0103031439170.24948-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001, Richard B. Johnson wrote:

> Note that two subsequent calls to gettimeofday() must not return the
> same time even if your CPU runs infinitely fast. I haven't seen any
> kernel in the past few years that fails this test.

i don't see any requirement for this in SuS.

http://www.opengroup.org/onlinepubs/007908799/xsh/gettimeofday.html

it'd be a pretty disappointing requirement.

-dean

