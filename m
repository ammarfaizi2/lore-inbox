Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbTEGOVv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbTEGOVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:21:51 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:62381 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263225AbTEGOVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:21:36 -0400
Date: Wed, 7 May 2003 16:33:15 +0200
From: Torsten Landschoff <torsten@debian.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030507143315.GA6879@stargate.galaxy>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030507135657.GC18177@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 03:56:57PM +0200, Jörn Engel wrote:
> Agreed, partially. There is the current issue of the kernel stack
> being just 8k in size and no decent mechanism in place to detect a
> stack overflow. And there is (arguably) the future issue of the kernel
> stack shrinking to 4k.

Pardon my ignorance, but why is the kernel stack shrinked to just a few
kilobytes? With 256MB of RAM in a typical desktop system it shouldn't
be a problem to use 256KB from that as the stack, but I am sure there
are good reasons to shrink it. 

Just curious, thanks for any info

	Torsten

PS: Joern, you don't by chance know my sister (kirsten@wh.fh-wedel.de)??
:-))
