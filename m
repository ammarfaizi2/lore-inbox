Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbTIYH7n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 03:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbTIYH7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 03:59:43 -0400
Received: from vitelus.com ([64.81.243.207]:55701 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S261765AbTIYH7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 03:59:42 -0400
Date: Thu, 25 Sep 2003 00:58:52 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Complete I/O starvation with 3ware raid on 2.6
Message-ID: <20030925075852.GI22525@vitelus.com>
References: <20030925071252.GE22525@vitelus.com> <20030925004301.171f6645.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925004301.171f6645.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 12:43:01AM -0700, Andrew Morton wrote:
> An update to the 3ware driver was merged yesterday.  Have you used earlier
> 2.5 kernels?

More info: The load average is above ten just because of this copy,
and even cating /proc/cpuinfo takes 10 seconds.
