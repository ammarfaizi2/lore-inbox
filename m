Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132057AbRCYQQ3>; Sun, 25 Mar 2001 11:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132059AbRCYQQU>; Sun, 25 Mar 2001 11:16:20 -0500
Received: from schmee.sfgoth.com ([63.205.85.133]:54279 "EHLO
	schmee.sfgoth.com") by vger.kernel.org with ESMTP
	id <S132057AbRCYQQJ>; Sun, 25 Mar 2001 11:16:09 -0500
Date: Sun, 25 Mar 2001 08:15:24 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Wichert Akkerman <wichert@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t
Message-ID: <20010325081524.E30469@sfgoth.com>
In-Reply-To: <UTC200103251231.OAA10795.aeb@vlet.cwi.nl> <99l375$rn5$1@picard.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <99l375$rn5$1@picard.cistron.nl>; from wichert@cistron.nl on Sun, Mar 25, 2001 at 05:35:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman wrote:
> You are just delaying the problem then, at some point your uptime will
> be large enough that you have run through all 64bit pids for example.

64 bits is enough to fork 1 million processes per second for over
500,000 years.  I think that's putting the problem off far enough.

-Mitch
