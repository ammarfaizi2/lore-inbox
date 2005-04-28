Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVD1X36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVD1X36 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 19:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVD1X36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 19:29:58 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:5320 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S262317AbVD1X35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 19:29:57 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: dumb question: How to create your own log files in a kernel module?
To: Xin Zhao <uszhaoxin@gmail.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 29 Apr 2005 01:28:38 +0200
References: <3YlMk-iH-9@gated-at.bofh.it> <3YnEA-1VB-27@gated-at.bofh.it> <3YoqV-2JA-31@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DRIQx-00025m-Pa@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xin Zhao <uszhaoxin@gmail.com> wrote:

> Thanks for kind help.
> 
> I know printk can do this job. But what I really want is to print logs
> to a file specified by me instead of /var/log/messages.

RTFM.

man 5 syslogd.conf
-- 
Funny quotes:
39. Ever wonder about those people who spend $2.00 apiece on those little
    bottles of Evian water? Try spelling Evian backwards: NAIVE

