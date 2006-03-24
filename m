Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWCXLj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWCXLj1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 06:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWCXLj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 06:39:26 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:6801 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932082AbWCXLj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 06:39:26 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
Date: Fri, 24 Mar 2006 22:38:57 +1100
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
References: <1143198208.7741.8.camel@homer> <1143198459.7741.14.camel@homer>
In-Reply-To: <1143198459.7741.14.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603242238.57830.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 22:07, Mike Galbraith wrote:
> patch 2/6
>
> This patch just fixes a bug waiting for a place to happen.  If anyone
> ever decides to use TASK_NONINTERACTIVE along with TASK_UNINTERRUPTIBLE,
> bad things will happen.

> Signed-off-by: Mike Galbraith <efault@gmx.de>

Acked-by: Con Kolivas <kernel@kolivas.org>
