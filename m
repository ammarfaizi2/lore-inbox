Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVAAIyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVAAIyU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 03:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVAAIyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 03:54:20 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:49284 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S262200AbVAAIyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 03:54:18 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: kconfig: help includes dependency information
To: Ingo Oeser <ioe-lkml@axxeo.de>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sat, 01 Jan 2005 09:58:36 +0100
References: <fa.hcrei7d.knakqt@ifi.uio.no> <fa.gau82p1.1g24ton@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1Ckf5o-000126-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:

>> #   kconfig: help includes dependency information

> "depends on:" is not really needed, since you usually cannot select any
> option, where you didn't fulfill the dependencies, AFAICS.

If you can't select the option, you'll still be able to see it in xconfig
and read which option you missed to select.

