Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbTFTUKw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 16:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbTFTUKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 16:10:52 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:48343 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264569AbTFTUKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 16:10:51 -0400
Date: Fri, 20 Jun 2003 22:24:44 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Must-fix] Keyboard occasionally endlessly repeating keys
Message-ID: <20030620202444.GD22732@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After having upgraded my notebook to 2.5.72, I noticed a rare problem,
that occurs about twice a day, maybe more.  After pressing a key, it
gets repeated endlessly until the next key is pressed.  When typing
fast, it is quite possible to cover up a couple of these, as the
repeats appear to happen at the set keyboard rates.  Problem never
occured with any 2.4 kernel.

I remember having read about this problem on the list before, but
didn't search my archive yet.  Also, I consider this to be a show
stopper, as the bug is already nasty when hitting 'q' inside mutt once
and might have worse effects with other programs.  YMMV.

Jörn

-- 
Rules of Optimization:
Rule 1: Don't do it.
Rule 2 (for experts only): Don't do it yet.
-- M.A. Jackson 
