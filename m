Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266682AbUBMC6U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 21:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266689AbUBMC6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 21:58:20 -0500
Received: from mail.shareable.org ([81.29.64.88]:23426 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266682AbUBMC6T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 21:58:19 -0500
Date: Fri, 13 Feb 2004 02:58:14 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: John Bradford <john@grabjohn.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040213025814.GE25499@mail.shareable.org>
References: <20040209115852.GB877@schottelius.org> <200402122039.19143.robin.rosenberg.lists@dewire.com> <200402122113.i1CLDqoB000179@81-2-122-30.bradfords.org.uk> <200402122329.11182.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402122329.11182.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Rosenberg wrote:
> Most shell scripts break if I even have a space in a filename.  This
> shouldn't be any worse than that. The space issue is really serious
> (but I don't think that can be fixed other than teaching people to
> program properly, and possibly improving bash's knowledge of the
> difference between a space and argument separator).

Space works fine for me.  Completion, wildcard expansion, variable
substition etc. all fine.  Bash doesn't need changing - your scripts do.

-- Jamie
