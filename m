Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUAJSgE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 13:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265297AbUAJSgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 13:36:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:2241 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265291AbUAJSgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 13:36:01 -0500
Date: Sat, 10 Jan 2004 10:29:12 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Unhork ymfpci broken by hasty janitors
Message-Id: <20040110102912.78ef218b.rddunlap@osdl.org>
In-Reply-To: <200401101805.i0AI50x8012960@hera.kernel.org>
References: <200401101805.i0AI50x8012960@hera.kernel.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jan 2004 17:49:31 +0000 Linux Kernel Mailing List <linux-kernel@vger.kernel.org> wrote:

| ChangeSet 1.1391, 2004/01/10 15:49:31-02:00, zaitcev@redhat.com
| 
| 	[PATCH] Unhork ymfpci broken by hasty janitors
| 	
| 	- Do not use schedule_timeout with spinlocks taken.
| 	- Restore missing kfree's.

some janitors maybe.  but "hasty janitors" != "kernel-janitors project".

BK shows previous changes here by "alan", "patch", and "torvalds",
so they must have been made by "patch".  8:)

--
~Randy
