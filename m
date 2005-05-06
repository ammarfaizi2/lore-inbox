Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVEFH1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVEFH1X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 03:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVEFH1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 03:27:23 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:40635 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S261158AbVEFH1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 03:27:20 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: telnet bug in fedora Core 4 test 2
To: kylin <fierykylin@gmail.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 06 May 2005 04:37:19 +0200
References: <40QM4-1IO-21@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DTsiN-0002cd-KI@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kylin <fierykylin@gmail.com> wrote:

> when i try to start it  using telnetd....
> then error evolves like this:
> telnetd:get peername:socket operation on non-socket

RTFM, telnetd is to be started by inetd.
-- 
Why did the hacker cross the road? To get to the other side.
Why did the cracker cross the road? To get what was on the other side.
The difference is small, but important.
        -- Gandalf Parker

