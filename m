Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbUDZIUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUDZIUE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 04:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUDZIUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 04:20:04 -0400
Received: from main.gmane.org ([80.91.224.249]:3469 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261479AbUDZIUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 04:20:00 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: PROBLEM: Kernel lockup on alpha with heavy IO
Date: Mon, 26 Apr 2004 10:19:57 +0200
Message-ID: <yw1x65bnm9qq.fsf@kth.se>
References: <408C75E4.50908@treshna.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:RTL1cAq/D835bY80gqAXIykmZ8o=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dru <andru@treshna.com> writes:

> I've recently installed debian on a alpha box and have a problem with
> the kernel locking up

[...]

> an hour.  I am running a mixture of ext3 and xfs for partitions.

There have been reports of trouble with XFS using post-2.6.3 kernel on
Alpha, see http://marc.theaimsgroup.com/?l=linux-kernel&m=108187914916911&w=2.

-- 
Måns Rullgård
mru@kth.se

