Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTKXW6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 17:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbTKXW6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 17:58:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:55974 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261506AbTKXW6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 17:58:36 -0500
Date: Mon, 24 Nov 2003 14:58:35 -0800
From: cliff white <cliffw@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Announce: Kernel Tinderbox (OSDL)
Message-Id: <20031124145835.5ab123cc.cliffw@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Announcing: Linux Kernel Tinderbox

We are pleased to announce Tinderbox-based tool which Linux kernel
developers can leverage to flag defects and regressions in the Linux
kernel and to relate these defects and regressions to recent change sets
for the kernel.  The tool is under continuing development and it allows
for distributed testing of the kernel using multiple hardware platforms
and software configurations.  

This tool is derived from the Mozilla Tinderbox infrastructure, with
much help from the kind people at Async (http://www.async.com.br/) The
Linux Kernel Tinderbox is a client-server system: The clients  do a
continuous cycle of checking out, compiling and testing the latest 
code integrated into the source repository.  The server provides 
output as a set of web pages, showing current changes to the kernel 
tree and state of the client machines.  Client status is displayed as 
a set of time-ordered coloured boxes arranged into columns, one per
client. 

A prototype for the Linux Kernel Tinderbox is viewable at:

http://tinderbox.osdl.org/showbuilds.pl?tree=linux2.5-bk

Project documentation is located at:

http://www.osdl.org/cgi-bin/osdl_development_wiki.pl?Linux_Kernel_Tinderbox

This project will support any architecture capable of running Linux. It
is our intent to encourage owners of these various hardware platforms to
contribute Tinderbox clients.

The basic kernel tinderbox client is at: 
http://developer.osdl.org/cliffw/kernel_tinderclient.tar.gz

Support is via a mailing list:
Kernel-tinderbox@lists.osdl.org
http://lists.osdl.org/mailman/listinfo/kernel-tinderbox

Let us know if you can provide a non-Intel client machine

Cliff White
John Cherry
OSDL

-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
