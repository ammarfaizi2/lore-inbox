Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266809AbSL3Kko>; Mon, 30 Dec 2002 05:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266841AbSL3Kkn>; Mon, 30 Dec 2002 05:40:43 -0500
Received: from cmailm3.svr.pol.co.uk ([195.92.193.19]:12562 "EHLO
	cmailm3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266809AbSL3Kkn>; Mon, 30 Dec 2002 05:40:43 -0500
Date: Mon, 30 Dec 2002 10:49:25 +0000
To: Kevin Corry <corry@ecn.purdue.edu>
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>, dm-devel@sistina.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm.c : Correctly initialize bio clone-info index
Message-ID: <20021230104925.GA2703@reti>
References: <200212272154.gBRLs6kj013449@shay.ecn.purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212272154.gBRLs6kj013449@shay.ecn.purdue.edu>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2002 at 04:54:06PM -0500, Kevin Corry wrote:
> Initialize the clone-info's index to the original bio's index. Required to
> properly handle stacking DM devices.

Agreed, thanks.

- Joe
