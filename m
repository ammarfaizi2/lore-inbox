Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUDSIOR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 04:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbUDSIOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 04:14:17 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:19918 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264213AbUDSIOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 04:14:14 -0400
Subject: Re: 2.6.5 pts problem
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: joshk@triplehelix.org, midian@ihme.org, hpa@zytor.com
Content-Type: text/plain
Organization: 
Message-Id: <1082353929.850.126.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 Apr 2004 01:52:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> As you see, pts is just growing, not using the old used numbers.
>
> The implementation was changed intentionally to make
> it that way. The numbers will only be recycled once we
> go over the max number of psuedoterminals, I think..

You can also recycle the numbers by rebooting.
That's what I do. :-/

(I can't be spending 10% of my disk on a giant wtmp
file. Also, I use the tty names for xterm titles now.
If they get too big, the GNOME taskbar button titles
get truncated.)


