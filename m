Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVDTG6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVDTG6B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 02:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVDTG6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 02:58:01 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:16513 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261348AbVDTG55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 02:57:57 -0400
X-ORBL: [67.124.119.21]
Date: Tue, 19 Apr 2005 23:57:51 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Harish K Harshan <harish@amritapuri.amrita.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i830 lockup
Message-ID: <20050420065751.GA9791@taniwha.stupidest.org>
References: <42225.203.197.150.195.1113980805.squirrel@mail.amrita.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42225.203.197.150.195.1113980805.squirrel@mail.amrita.ac.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2005 at 12:36:45PM +0530, Harish K Harshan wrote:

> CPU 0 : Machine Check Exception : 0000000000000004
> Bank 0 : a200000084010400
> Kernel panic : CPU context corrupt
> In interrupt handler - not syncing

CPU got messed up...  could be a bad CPU/cache/chipset or simply it's
over heating or has a bad powersupply.
