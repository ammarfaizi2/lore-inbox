Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTLVSYc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 13:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTLVSYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 13:24:31 -0500
Received: from havoc.gtf.org ([63.247.75.124]:52415 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262015AbTLVSYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 13:24:31 -0500
Date: Mon, 22 Dec 2003 13:24:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS][2.6.0][e100 new driver] mii-diag oops with -F option
Message-ID: <20031222182430.GA17852@gtf.org>
References: <Pine.LNX.4.44.0312221236130.406-100000@coredump.sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312221236130.406-100000@coredump.sh0n.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 12:37:49PM -0500, Shawn Starr wrote:
> Sorry, this is with the new Intel e100 pro driver not the old eepro100
> driver.

New is a bit non-specific :)  What driver version?

If you remove all occurences of "__devinit", does the oops go away?
