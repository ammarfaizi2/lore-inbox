Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263816AbTDULjj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 07:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263817AbTDULji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 07:39:38 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:50181 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S263816AbTDULjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 07:39:37 -0400
From: Peter Benie <peterb@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16035.56139.893197.189080@chiark.greenend.org.uk>
Date: Mon, 21 Apr 2003 12:51:39 +0100
To: Andrew Clayton <andrew@sol-1.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Log your dead hard disk drives here
In-Reply-To: <1050891929.1091.29.camel@alpha.digital-domain.net>
References: <1050883793.1089.16.camel@alpha.digital-domain.net>
	<20030421014801.GA21949@ip68-101-124-193.oc.oc.cox.net>
	<1050891929.1091.29.camel@alpha.digital-domain.net>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Clayton writes:
 > On Mon, 2003-04-21 at 02:48, Barry K. Nathan wrote:
 > > On Mon, Apr 21, 2003 at 01:09:54AM +0100, Andrew Clayton wrote:
 > > > http://digital-domain.net/fscked-disk/
 > > 
 > > What does your site do that the StorageReview.com Reliability Survey
 > > doesn't? (i.e., the SR.com survey has been around for a while, why do we
 > > need another?)
 > 
 > Perhaps we don't, I wasn't aware of the above site. Looking at it
 > though, mine is obviously much more to the point and is targeting one
 > specific area, in that it is just logging drive failures.

I'm not convinced that you are collecting enough information to get
useful statistics, in particular, you lack any data about drives that
haven't failed yet.

Suppose that there are two vendors sell drives with identical
characteristics, one of which sells twice as many drives as the
other. In your statistics, you will give the appearance that the more
popular drive performs less well because you see twice as many
failures.

A better approach would be for people to register their drives with
you when they are new, and then to inform you when the drive fails or
is otherwise disposed of. The problem here would be to keep track of
the drives to ensure that failures really do get logged.

Peter
