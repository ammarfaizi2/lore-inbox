Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbVCaBOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVCaBOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 20:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVCaBOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 20:14:36 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:39917 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S262580AbVCaBNU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 20:13:20 -0500
From: David Brownell <david-b@pacbell.net>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.11, USB: High latency?
Date: Wed, 30 Mar 2005 17:13:19 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200503301457.35464.david-b@pacbell.net> <1112229816.19975.9.camel@mindpipe>
In-Reply-To: <1112229816.19975.9.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503301713.19920.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 March 2005 4:43 pm, Lee Revell wrote:
> On Wed, 2005-03-30 at 14:57 -0800, David Brownell wrote:
> > Quoth rlevell@joe-job.com:
> > > I think this is connected to a problem people have been reporting on the
> > > Linux audio lists.  With some USB chipsets, USB audio interfaces just
> > > don't work.  There are dropouts even at very high latencies.  
> 
> Please don't trim cc: lists.  Always use reply-to-all for LKML mail.

Please don't assume everyone subscribes to LKML, or that
everything crafted to be threaded more-or-less-correctly
was really crafted with any kind of "reply" command.  :)



