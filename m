Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbSJYJNG>; Fri, 25 Oct 2002 05:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261324AbSJYJNG>; Fri, 25 Oct 2002 05:13:06 -0400
Received: from elixir.e.kth.se ([130.237.48.5]:30991 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S261321AbSJYJNF>;
	Fri, 25 Oct 2002 05:13:05 -0400
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Ed Sweetman <ed.sweetman@wmich.edu>, linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
References: <3DB82ABF.8030706@colorfullife.com>
	<200210242048.36859.earny@net4u.de> <3DB85385.6030302@wmich.edu>
	<20021024202654.GA14351@suse.de>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 25 Oct 2002 11:19:16 +0200
In-Reply-To: Dave Jones's message of "Thu, 24 Oct 2002 21:26:54 +0100"
Message-ID: <yw1xof9i27vv.fsf@starwars.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> writes:

> The functions being benchmarked are written in assembly.
> gcc will not change these in any way, making compiler flags
> or revision irrelevant.

Doesn't gcc schedule inline assembly instructions?

-- 
Måns Rullgård
mru@users.sf.net
