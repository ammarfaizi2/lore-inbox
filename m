Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTIYHvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 03:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbTIYHvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 03:51:08 -0400
Received: from vitelus.com ([64.81.243.207]:46997 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S261769AbTIYHvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 03:51:07 -0400
Date: Thu, 25 Sep 2003 00:50:16 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Complete I/O starvation with 3ware raid on 2.6
Message-ID: <20030925075016.GG22525@vitelus.com>
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

Unfortunately not. I copied a day-old CVS tree to the machine but
decided to update before compiling to get the latest-and-greatest. I
did notice the 3ware updates.

I rebooted with the deadline scheduler. It definately isn't helping.
