Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266364AbUIEI7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266364AbUIEI7T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 04:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUIEI7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 04:59:19 -0400
Received: from mail.enyo.de ([212.9.189.167]:11 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S266364AbUIEI7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 04:59:18 -0400
To: Tim Connors <tconnors+linuxkernel1094371411@astro.swin.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: why do i get "Stale NFS file handle" for hours?
References: <chdp06$e56$1@sea.gmane.org>
	<1094348385.13791.119.camel@lade.trondhjem.org>
	<413A7119.2090709@upb.de>
	<1094349744.13791.128.camel@lade.trondhjem.org>
	<413A789C.9000501@upb.de>
	<1094353267.13791.156.camel@lade.trondhjem.org>
	<slrn-0.9.7.4-19971-22570-200409051803-tc@hexane.ssi.swin.edu.au>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Sun, 05 Sep 2004 10:59:16 +0200
In-Reply-To: <slrn-0.9.7.4-19971-22570-200409051803-tc@hexane.ssi.swin.edu.au>
	(Tim Connors's message of "Sun, 5 Sep 2004 18:17:53 +1000")
Message-ID: <87y8jphz17.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tim Connors:

> Background:
>
> We have a compute cluster of machines all running SuSE's 2.4.20, or
> thereabouts. The nfs servers run Linus's 2.4.26, talking to ext3, on
> bigass apple Xserves.

Which NFS server software are you using?
