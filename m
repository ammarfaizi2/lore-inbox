Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263845AbUEXClp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbUEXClp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 22:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263842AbUEXClo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 22:41:44 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:45300 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263845AbUEXCll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 22:41:41 -0400
Date: Sun, 23 May 2004 22:41:36 -0400
From: Tom Vier <tmv@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.6.6 IDE shutdown problems.
Message-ID: <20040524024136.GB2502@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <BAY18-F105X7rz6AvEm0002622f@hotmail.com> <200405151506.20765.bzolnier@elka.pw.edu.pl> <c8bdqv$lib$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8bdqv$lib$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 06:25:51PM -0400, Bill Davidsen wrote:
> I would think that if the drive didn't properly flush cache on shutdown 
> that it might cause corruption. Feel free to tell me no drive would 
> bahave like that ;-)

why not add a one or two second delay before? i doubt any drive holds its
writeback that long.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
