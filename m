Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131785AbRAJAvt>; Tue, 9 Jan 2001 19:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131511AbRAJAvi>; Tue, 9 Jan 2001 19:51:38 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:19719 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S130191AbRAJAv3>; Tue, 9 Jan 2001 19:51:29 -0500
Date: Tue, 09 Jan 2001 19:51:23 -0500
From: Chris Mason <mason@suse.com>
To: Marc Lehmann <pcg@goof.com>, BUGTRAQ@SECURITYFOCUS.COM,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] major security bug in reiserfs (may affect SuSE
 Linux)
Message-ID: <14260000.979087883@tiny>
In-Reply-To: <20010110004201.A308@cerebro.laendle>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, January 10, 2001 12:42:01 AM +0100 Marc Lehmann
<pcg@goof.com> wrote:

> We are still investigating, but there seems to be a major security problem
> in at least some versions of reiserfs. Since reiserfs is shipped with
> newer versions of SuSE Linux and the problem is too easy to reproduce and
> VERY dangerous I think alerting people to this problem is in order.
> 

Sorry, a quick attempt at reproducing on 2.2.17 and 2.2.19 kernels did not
cause an oops.  Could you please send me a decoded version of the oops to
help track things down?

thanks,
Chris
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
