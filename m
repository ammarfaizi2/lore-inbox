Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWH0Ufw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWH0Ufw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 16:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWH0Ufw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 16:35:52 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:62411 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751129AbWH0Ufw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 16:35:52 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org, wtarreau@hera.kernel.org,
       mtosatti@redhat.com, volkerdi@slackware.com
Subject: Re: Linux 2.4.33.2
Date: Mon, 28 Aug 2006 06:35:47 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <jc04f2hnp2vgoupei4q6fm4o9ci87ep83o@4ax.com>
References: <200608271235.k7RCZlru005427@harpo.it.uu.se>
In-Reply-To: <200608271235.k7RCZlru005427@harpo.it.uu.se>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2006 14:35:47 +0200 (MEST), Mikael Pettersson <mikpe@it.uu.se> wrote:

>On Tue, 22 Aug 2006 21:23:00 +0000, Willy Tarreau wrote:
...
>>I dont think that this problem might affect many other distros since those
>>shipping an NPTL-enabled libc with both 2.4 and 2.6 mainline are rare. If
>>anyone else encounters the problem, Pat has the fix.
>
>Can anyone provide a URL to the glibc fix?

For slack-10.2, look in:
<ftp://ftp.slackware.com/pub/slackware/slackware-10.2/patches/source/glibc>

Grant.
