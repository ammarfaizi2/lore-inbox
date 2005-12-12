Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVLLSuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVLLSuy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 13:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVLLSux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 13:50:53 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:42449 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932132AbVLLSuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 13:50:52 -0500
Date: Mon, 12 Dec 2005 10:50:38 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       lse-tech@lists.sourceforge.net,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jay Lan <jlan@sgi.com>, Jens Axboe <axboe@suse.de>
Subject: Re: [Lse-tech] [RFC][Patch 1/5] nanosecond timestamps and diffs
In-Reply-To: <43975E6D.9000301@watson.ibm.com>
Message-ID: <Pine.LNX.4.62.0512121049400.14868@schroedinger.engr.sgi.com>
References: <43975D45.3080801@watson.ibm.com> <43975E6D.9000301@watson.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Dec 2005, Shailabh Nagar wrote:

> +void getnstimestamp(struct timespec *ts)

There is already getnstimeofday in the kernel.

