Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263931AbTDNVYJ (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263938AbTDNVYJ (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:24:09 -0400
Received: from air-2.osdl.org ([65.172.181.6]:24527 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263931AbTDNVYI (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 17:24:08 -0400
Date: Mon, 14 Apr 2003 14:34:53 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Joel.Becker@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.67-mm2
Message-Id: <20030414143453.59e7558c.rddunlap@osdl.org>
In-Reply-To: <20030414143141.632da899.akpm@digeo.com>
References: <20030412180852.77b6c5e8.akpm@digeo.com>
	<20030414174818.GR4917@ca-server1.us.oracle.com>
	<20030414143141.632da899.akpm@digeo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Apr 2003 14:31:41 -0700 Andrew Morton <akpm@digeo.com> wrote:

| Joel Becker <Joel.Becker@oracle.com> wrote:
| >
| > On Sat, Apr 12, 2003 at 06:08:52PM -0700, Andrew Morton wrote:
| > > . I've changed the 32-bit dev_t patch to provide a 12:20 split rather than
| > >   16:16.  This patch is starting to drag a bit and unless someone stops me I
| > >   might just go submit the thing.
| > 
| > 	Cool, but before you go off and push, maybe kick the appropriate
| > folks about making the 32/64 decision?
| > 
| 
| It'll be 32+32.  I was just trolling.

Good.  and good.

--
~Randy
