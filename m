Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVCTURA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVCTURA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 15:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVCTURA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 15:17:00 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:63447 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S261253AbVCTUQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 15:16:59 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: af_unix.c, KBUILD_MODNAME and unix
To: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 20 Mar 2005 21:21:27 +0100
References: <fa.jj4t62d.1j5ccif@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DD6vS-0002ZQ-7r@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <magnus.damm@gmail.com> wrote:

> Solution? #undef unix?

#define unix unix?

provided nobody uses unix numerically.
