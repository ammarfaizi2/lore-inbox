Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266869AbUAXF5r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 00:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbUAXF5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 00:57:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:52160 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266869AbUAXF5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 00:57:46 -0500
Date: Fri, 23 Jan 2004 21:58:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: campbell@accelinc.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2 kernel and ext3 filesystems
Message-Id: <20040123215848.28dac746.akpm@osdl.org>
In-Reply-To: <20040124033208.GA4830@helium.inexs.com>
References: <20040124033208.GA4830@helium.inexs.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Campbell <campbell@accelinc.com> wrote:
>
> Was the ext3 filesystem ever back ported to the 2.2 kernel series?

It was written for 2.2, and then forward-ported.

ftp://ftp.kernel.org/pub/linux/kernel/people/sct/ext3/v2.2/
