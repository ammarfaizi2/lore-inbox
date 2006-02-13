Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWBMLrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWBMLrl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 06:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWBMLrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 06:47:40 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:34270 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751090AbWBMLrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 06:47:40 -0500
Date: Mon, 13 Feb 2006 12:47:32 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15:kernel/time.c: The Nanosecond and code duplication
In-Reply-To: <43F05143.29965.5D3E74@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Message-ID: <Pine.LNX.4.61.0602131239170.9696@scrub.home>
References: <43F05143.29965.5D3E74@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Feb 2006, Ulrich Windl wrote:

> I'm working on an integration of current NTP kernel algorithms for Linux 2.6. 

Ulrich, do you know of my patches at http://www.xs4all.nl/~zippel/ntp/patches-2.6.15-rc6-git2/ ?
I posted them already to lkml. They do this already (at least for the non 
pps parts).

bye, Roman
