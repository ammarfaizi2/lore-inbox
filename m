Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUBWGBx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 01:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbUBWGBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 01:01:53 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:30413 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S261832AbUBWGBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 01:01:51 -0500
Date: Sun, 22 Feb 2004 22:01:45 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs loff_t fix not in 2.6.3?
Message-ID: <20040223060145.GK18563@srv-lnx2600.matchmail.com>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040223054257.GI18563@srv-lnx2600.matchmail.com> <20040222215131.6b4c9d91.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222215131.6b4c9d91.rddunlap@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 09:51:31PM -0800, Randy.Dunlap wrote:
> On Sun, 22 Feb 2004 21:42:57 -0800 Mike Fedyk <mfedyk@matchmail.com> wrote:
> 
> | I have this patch below to fix the 4GB file size limit with knfsd.  Is it
> | still needed (alternate fix?), and what's the status of it?
> 
> It was merged after 2.6.3:
> http://linux.bkbits.net:8080/linux-2.5/cset@1.1557.1.82?nav=index.html|ChangeSet@-7d
> 
> Should be in any recent 2.6.3 + bk patch.

Thanks Randy.
