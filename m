Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUEQX5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUEQX5P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUEQX5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:57:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:48873 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262547AbUEQX5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:57:12 -0400
Date: Mon, 17 May 2004 16:59:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: joern@wohnheim.fh-wedel.de, arjanv@redhat.com, benh@kernel.crashing.org,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-Id: <20040517165919.04edcc77.akpm@osdl.org>
In-Reply-To: <20040517233515.GR5414@waste.org>
References: <20040513145640.GA3430@dreamland.darkstar.lan>
	<1084488901.3021.116.camel@gaston>
	<20040513182153.1feb488b.akpm@osdl.org>
	<20040514094923.GB29106@devserv.devel.redhat.com>
	<20040514114746.GB23863@wohnheim.fh-wedel.de>
	<20040514151520.65b31f62.akpm@osdl.org>
	<20040517233515.GR5414@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> I have a cleaned up version of this script in -tiny which is a bit
> nicer for adding new arches to and produces simpler output:

OK, thanks.  Joern, could you please own this megaproject?  Send
me any needed diffs against -mm3?
