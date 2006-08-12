Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWHLCS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWHLCS2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 22:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWHLCS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 22:18:28 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:64679 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932073AbWHLCS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 22:18:28 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Kasper Sandberg <lkml@metanurb.dk>,
       Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.33 released
Date: Sat, 12 Aug 2006 12:18:23 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <e8eqd2ho9a92hiqohjfmkhsbohl5beabvf@4ax.com>
References: <200608110418.k7B4IqDn017355@hera.kernel.org> <1155318180.23933.7.camel@localhost> <20060811190923.GJ8776@1wt.eu>
In-Reply-To: <20060811190923.GJ8776@1wt.eu>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2006 21:09:23 +0200, Willy Tarreau <w@1wt.eu> wrote:

>Hello,
>
>On Fri, Aug 11, 2006 at 07:43:00PM +0200, Kasper Sandberg wrote:
>> On Fri, 2006-08-11 at 04:18 +0000, Marcelo Tosatti wrote:
>> > final:
>> > 
>> > - 2.4.33-rc3 was released as 2.4.33 with no changes.
>> I have one suggestion for the 2.4 tree, next time a few changes is
>> introduced, they could be put as a bugfix release, as with the 2.6
>> branch now, so that it doesent end up taking years for a new 2.4
>> release, and instead a point release(if any such thing happens at all)
>
>This has already the case with the hotfix tree since 18 months or so. A
>hotfix release is issued when there are important fixes. Anyway, I was
>thinking about releasing pre-releases more often. Also, you might have
>noticed that the slowdown is more important during -rc for obvious reasons.

>To solve this problem, I intend to maintain a 'next' branch in the tree
>which will contain the fixes that can wait for next version. It should
>help us batch the fixes and reduce the latency between important fixes
>and the associated release.

Perhaps time to follow the 2.6.nn-stable naming scheme?  Since you're in 
the driver's seat now?  This may be less confusing to 2.4 series users.

You'd have an idea how popular your hotfix project has been from your 
server download stats?  I've mostly run hotfix-latest on firewall 24/7 
since you started the project.

Cheers,
Grant.
