Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262976AbVDLXdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbVDLXdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbVDLXZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 19:25:23 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:17333 "EHLO
	mail-in-06.arcor-online.net") by vger.kernel.org with ESMTP
	id S262539AbVDLXWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 19:22:03 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: RE: Digi Neo 8: linux-2.6.12_r2  jsm driver
To: Kilau@arcor-online.net, Scott <Scott_Kilau@digi.com>,
       Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       Ihalainen Nickolay <ihanic@dev.ehouse.ru>, admin@list.net.ru,
       linux-kernel@vger.kernel.org, Wen Xiong <wendyx@us.ibm.com>
Reply-To: 7eggert@gmx.de
Date: Wed, 13 Apr 2005 01:21:39 +0200
References: <3SAEx-7Yo-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DLUhQ-0001ad-Kd@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kilau, Scott <Scott_Kilau@digi.com> wrote:

> However, neither IBM nor Digi wants this thread's patch to be applied,
> and yet Christoph wants to do it, completely out of spite, to break our
> out-of-tree open source driver.
> 
> This is the problem that I have.

I think you should supply a patch that makes the in-kernel driver print a
short notice about your other driver. E.g.
----
The foo driver is a stripped-down version of the bar driver. To get the
additional configuration and diagnosis infrastructure, see the
instructions on url.
----
-- 
Top 100 things you don't want the sysadmin to say:
49. What's this switch for anyways...?
