Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbTDLIcd (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 04:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTDLIcd (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 04:32:33 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:18831 "EHLO
	humilis.humilis.net") by vger.kernel.org with ESMTP id S263200AbTDLIcc (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 04:32:32 -0400
Date: Sat, 12 Apr 2003 10:44:16 +0200
From: Ookhoi <ookhoi@humilis.net>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       David Woodhouse <dwmw2@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       James Bourne <jbourne@mtroyal.ab.ca>
Subject: Re: ext3 clings to you like flypaper
Message-ID: <20030412104416.A1462@humilis>
Reply-To: ookhoi@humilis.net
References: <78320000.1045465489@[10.10.2.4]> <1045482621.29000.40.camel@passion.cambridge.redhat.com> <2460000.1045500532@[10.10.2.4]> <20030217170851.GA18693@wohnheim.fh-wedel.de> <9850000.1045504008@[10.10.2.4]> <20030217183113.GA24922@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217183113.GA24922@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.19i
X-Uptime: 17:18:44 up 32 days,  4:13, 23 users,  load average: 0.01, 0.04, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J?rn Engel wrote (ao):
> You appear to not have /etc/mtab as a symlink to /proc/mounts. One of
> the first things I do on fresh debian installations. The kernel should
> know better than some file, especially when / is mounted ro.

This breaks quotaon.
