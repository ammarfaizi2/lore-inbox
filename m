Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317992AbSGWINZ>; Tue, 23 Jul 2002 04:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317993AbSGWINZ>; Tue, 23 Jul 2002 04:13:25 -0400
Received: from cmailg7.svr.pol.co.uk ([195.92.195.177]:55824 "EHLO
	cmailg7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S317992AbSGWINY>; Tue, 23 Jul 2002 04:13:24 -0400
Date: Tue, 23 Jul 2002 09:16:11 +0100
To: Steve Pratt <slpratt@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020723081611.GB1393@fib011235813.fsnet.co.uk>
References: <OF5933E2F2.D3E9CDE3-ON85256BFE.00744D4A@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF5933E2F2.D3E9CDE3-ON85256BFE.00744D4A@pok.ibm.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 04:42:19PM -0500, Steve Pratt wrote:
> Also, if it is so easy to link parted with LVM2 to get greater
> functionality,
> why hasn't the LVM team or Andrew done this yet?

Because we don't want to.  LVM is a volume manager *not* an fs
manager.  We may however release a few little shell scripts, as a
seperate package, that wrap LVM2 commands and fs commands - no more
than this is needed for your much vaunted fs functionality.

- Joe
