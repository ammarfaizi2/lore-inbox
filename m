Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264353AbTCYXZg>; Tue, 25 Mar 2003 18:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264373AbTCYXZg>; Tue, 25 Mar 2003 18:25:36 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:62101 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S264353AbTCYXZf>; Tue, 25 Mar 2003 18:25:35 -0500
Date: Tue, 25 Mar 2003 15:36:40 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: whitney@math.berkeley.edu
To: LKML <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.65 kills dosemu, 2.5.64 is OK
Message-ID: <Pine.LNX.4.44.0303251531480.18554-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

>From time to time I run an old DOS game under dosemu under X.  In 2.5.64,
everything works fine.  In 2.5.65, after about a minute, the display locks
up.  Alt-Sysrq stills works OK.  Before I start a binary search on the -bk
snapshots between 2.5.64 and 2.5.65, does anyone have a suggestion for the
culprit or a better debugging method?

Thanks, Wayne

