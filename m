Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbTHaPsg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 11:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTHaPsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 11:48:36 -0400
Received: from [213.39.233.138] ([213.39.233.138]:50655 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262084AbTHaPsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 11:48:30 -0400
Date: Sun, 31 Aug 2003 17:48:27 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Dan Kegel <dank@kegel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Andrea VM changes
Message-ID: <20030831154827.GE30196@wohnheim.fh-wedel.de>
References: <3F52199B.5020808@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F52199B.5020808@kegel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 August 2003 08:51:55 -0700, Dan Kegel wrote:
> 
> In the test-and-measurement system I'm developing,
> it turned out the sanest thing to do with OOM conditions
> was to consider them user errors, and to handle them
> by dumping memory usage info about processes and slab caches,
> then halt.  It's been very helpful because it turns flaky
> conditions into rock-solid failures.  Too bad this drastic
> approach isn't appropriate for general use.

Sound interesting.  Can you send a patch for the interested and
unafraid?

Jörn

-- 
A quarrel is quickly settled when deserted by one party; there is
no battle unless there be two.
-- Seneca
