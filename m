Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264651AbTGBDUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 23:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264653AbTGBDUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 23:20:20 -0400
Received: from granite.he.net ([216.218.226.66]:5388 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264651AbTGBDUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 23:20:16 -0400
Date: Tue, 1 Jul 2003 20:34:17 -0700
From: Greg KH <greg@kroah.com>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: USB Serial oops in 2.4.22-pre2
Message-ID: <20030702033417.GB3272@kroah.com>
References: <200307021222.09764.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307021222.09764.harisri@bigpond.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 12:22:09PM +1000, Srihari Vijayaraghavan wrote:
> [1.] One line summary of the problem:
> USB Serial oops in 2.4.22-pre2

Does this happen with 2.4.21?

Anyway, this is a known bug.  See the linux-usb-devel archives for what
needs to be done to fix this, or just switch to 2.5, as it's fixed there
:)

thanks,

greg k-h
