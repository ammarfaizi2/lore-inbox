Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWIABhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWIABhH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWIABhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:37:06 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:57825 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S964857AbWIABhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:37:03 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.33.3
Date: Fri, 01 Sep 2006 11:37:01 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <dh3ff2lapcu7267j23cjvn9p5v1pvusr6u@4ax.com>
References: <20060831202636.GA26765@hera.kernel.org>
In-Reply-To: <20060831202636.GA26765@hera.kernel.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2006 20:26:36 +0000, Willy Tarreau <wtarreau@hera.kernel.org> wrote:

>Hi !
>
>This is the third version of 2.4.33-stable. The fix for the UDF deadlock
>mentionned in previous announce has been merged, as well as the second
>part of the SCTP fix. Other patches fix rather minor but annoying bugs.

stable
+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +
| kernel version  |deltree|hal    |niner  |peetoo |pooh   |sempro |silly  |tosh   |
+ - - - - - - - - + - - - + - - - + - - - + - - - + - - - + - - - + - - - + - - - +
| 2.4.33.3 [2,3]  |   Y   |   Y   |   Y   |   Y   |       |   Y   |   Y   |   Y   |
...
[1] unofficial rename of 2.4.33.1 for testing under slackware, to be resolved...
[2] requires upgrade to glibc-solibs-2.3.5-i486-6_slack10.2.tgz for slack-10.2
[3] deltree still uses rename hack [1] until upgrade to slackware-11.0

  -- <http://bugsplatter.mine.nu/test/linux-2.4/>

Works for me :o)

Grant.
