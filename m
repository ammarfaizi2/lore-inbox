Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbULZSHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbULZSHD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 13:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbULZSHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 13:07:03 -0500
Received: from 76.80-203-227.nextgentel.com ([80.203.227.76]:7891 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S261718AbULZSG5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 13:06:57 -0500
To: Larry McVoy <lm@work.bitmover.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: lease.openlogging.org is unreachable
References: <200412250121_MC3-1-91AF-7FBB@compuserve.com>
	<20041226011222.GA1896@work.bitmover.com>
	<20041226030957.GA8512@work.bitmover.com>
	<yw1x7jn5bbj1.fsf@inprovide.com>
	<20041226160205.GB26574@work.bitmover.com>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Sun, 26 Dec 2004 19:06:52 +0100
In-Reply-To: <20041226160205.GB26574@work.bitmover.com> (Larry McVoy's
 message of "Sun, 26 Dec 2004 08:02:05 -0800")
Message-ID: <yw1xmzw19bnn.fsf@inprovide.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

> On Sun, Dec 26, 2004 at 11:26:42AM +0100, M?ns Rullg?rd wrote:
>> I've been bitten by that one, as I occasionally work off-line.  Is
>> there some way I can make BK renew the leases a week or so before they
>> expire?
>
> In theory, we do that already.  By you can always do a "bk lease renew"
> and that will get you a new lease.  "bk lease show" will show you your
> lease.

Looking closer, the problem is that my hostname keeps changing,
depending on which network the laptop is on, if any.  I guess the
simple solution is to remember to renew the lease for the no-net
hostname before going offline.

-- 
Måns Rullgård
mru@inprovide.com
