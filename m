Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263570AbTJQRog (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 13:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbTJQRog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 13:44:36 -0400
Received: from main.gmane.org ([80.91.224.249]:5021 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263570AbTJQRoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 13:44:34 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Software RAID5 with 2.6.0-test
Date: Fri, 17 Oct 2003 19:44:31 +0200
Message-ID: <yw1xu167kbcw.fsf@users.sourceforge.net>
References: <1065690658.10389.19.camel@slurv> <Pine.LNX.3.96.1031017125544.24004C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:RJf7p63iwQdjxJxq7IcI5Vo3K6c=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

>> However, I wouln't count on superior performance from software based
>> RAID 5 (ata/fakeraid or otherwise), that is whats real raid controllers
>> are for.
>
> While an overloaded system may benefit from offloaded the CPU
> requirements of RAID, unless you go to a very expensive external unit
> the kernel RAID will usually outperform the inexpensive RAID embedded on
> a controller. The kernel simply knows more about the data needs and can
> can do things a controller can't.

What about the RAID controllers in the $400 category?  Surely, they
must be doing something better than the $50 fakeraid controllers.

-- 
Måns Rullgård
mru@users.sf.net

