Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbTEERJl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 13:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbTEERJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 13:09:17 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:29338 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263753AbTEERGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 13:06:09 -0400
Date: Mon, 5 May 2003 19:18:33 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Ezra Nugroho <ezran@goshen.edu>, linux-kernel@vger.kernel.org
Subject: Re: partitions in meta devices
Message-ID: <20030505171833.GA26246@wohnheim.fh-wedel.de>
References: <1052153060.29588.196.camel@ezran.goshen.edu> <3EB693B1.9020505@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EB693B1.9020505@gmx.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 May 2003 18:39:13 +0200, Carl-Daniel Hailfinger wrote:
> Ezra Nugroho wrote:
>> [partitioning problems]
> 
> Please reboot after partitioning.

This has always been bothering me. Why?
As long as no mounted partitions have been changed, I fail to see any
need for a reboot, except maybe lazy programming.

s/mounted/used/ for correctness fanatics.

Jörn

-- 
Rules of Optimization:
Rule 1: Don't do it.
Rule 2 (for experts only): Don't do it yet.
-- M.A. Jackson 
