Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbUF1WNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUF1WNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 18:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265241AbUF1WNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 18:13:51 -0400
Received: from web11505.mail.yahoo.com ([216.136.172.37]:22924 "HELO
	web11505.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261907AbUF1WNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 18:13:50 -0400
Message-ID: <20040628221349.55700.qmail@web11505.mail.yahoo.com>
Date: Mon, 28 Jun 2004 15:13:49 -0700 (PDT)
From: <ca_tex-kernel@yahoo.com>
Subject: GPL question
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully this is not going to start a huge thread war on open source
philosophy and such, but the company I work for has some proprietary code built
as a 2.4 linux kernel module for a product they sell.  They are concerned about
releasing the source code.  I noticed that what this code does and how it does
it seems pretty clean (at least GPL-wise), but it does modify sys_call_table to
add a system call which is then used to call the module from userland.  Can
they avoid releasing this code or is this crossing into a gray area?  I used to
think I more or less understood the basics of the GPL, but after talking to
their lawyers I am totally confused.  Thanks.


=====
Jarrett L. Redd (K9HMV)
