Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbTJRGzH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 02:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbTJRGzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 02:55:07 -0400
Received: from rth.ninka.net ([216.101.162.244]:48007 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261463AbTJRGzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 02:55:05 -0400
Date: Fri, 17 Oct 2003 23:55:01 -0700
From: "David S. Miller" <davem@redhat.com>
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org, shemminger@osdl.org
Subject: Re: IA32 (2.6.0-test8 - 2003-10-17.18.30) - 5 New warnings (gcc
 3.2.2)
Message-Id: <20031017235501.484af56d.davem@redhat.com>
In-Reply-To: <200310180644.h9I6iieH020718@cherrypit.pdx.osdl.net>
References: <200310180644.h9I6iieH020718@cherrypit.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Oct 2003 23:44:44 -0700
John Cherry <cherry@osdl.org> wrote:

> drivers/net/3c515.c:610: warning: `init_etherdev' is deprecated (declared at include/linux/etherdevice.h:44)

These will all disappear shortly, marking this deprecated was
a bit premature.
