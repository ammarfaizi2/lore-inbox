Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbUK3N0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbUK3N0l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 08:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbUK3NYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 08:24:43 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:404 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262066AbUK3NYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 08:24:35 -0500
Date: Tue, 30 Nov 2004 14:23:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bernard Hatt <bernard.hatt@ntlworld.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, mj@ucw.cz
Subject: Re: Yet another filesystem - sffs
Message-ID: <20041130132310.GC4670@openzaurus.ucw.cz>
References: <41AC2DBE.1080501@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AC2DBE.1080501@ntlworld.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I had an idea for a filesystem as an alternative to using a raw disk
> partition for storing a single (large) data file (eg. a DVD image or a
> database data file), adding the convenience of a file length, 
> permissions
> and a uid/gid.

Long time ago, Martin Mares did something very similar, IIRC it was called
smugfs.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

