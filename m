Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVCJBqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVCJBqp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbVCJBo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:44:26 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:59331 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S262725AbVCJBns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 20:43:48 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Linux 2.6.11.2
To: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Thu, 10 Mar 2005 02:46:29 +0100
References: <fa.dan38um.1m4gojq@ifi.uio.no> <fa.animhpl.r201hh@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1D9Ckw-0002C0-8S@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> wrote:

> I think you need both x.y.z=>x.y.z.N and x.y.z.N-1=>x.y.z.N patches. My
> systems which are following the -stable will just need the most recent,
> but doing x.y.z-1=>x.y.z.N gets really ugly for higher values of N.

bzcat ../patch-2.6.nn.[0-9].*|patch -p1
