Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTENGP4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 02:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTENGPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 02:15:45 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:3113 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262127AbTENGP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 02:15:27 -0400
Date: Tue, 13 May 2003 23:29:28 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm4
Message-Id: <20030513232928.3eaaab7b.akpm@digeo.com>
In-Reply-To: <87smri59on.fsf@lapper.ihatent.com>
References: <20030512225504.4baca409.akpm@digeo.com>
	<87vfwf8h2n.fsf@lapper.ihatent.com>
	<20030513001135.2395860a.akpm@digeo.com>
	<87n0hr8edh.fsf@lapper.ihatent.com>
	<20030513011232.67c300d0.akpm@digeo.com>
	<87addq7fr8.fsf@lapper.ihatent.com>
	<20030513145335.2337e0f7.akpm@digeo.com>
	<87smri59on.fsf@lapper.ihatent.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 06:28:10.0157 (UTC) FILETIME=[FD1FEDD0:01C319E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis <alexh@ihatent.com> wrote:
>
> Here's the result of some light poking in my mailbox (moving single
>  mails form one folder to another, moved about 8 mails while this
>  scrolled by:

Well something is performing a ton of writeout.  You'd expect
things to get a bit laggy.
