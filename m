Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUJ3Pb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUJ3Pb5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUJ3Pah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:30:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:5831 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261237AbUJ3PEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 11:04:53 -0400
Date: Sat, 30 Oct 2004 17:04:52 +0200
From: Andi Kleen <ak@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm2: konqueror segfaults for no reason
Message-ID: <20041030150452.GF20611@wotan.suse.de>
References: <200410291823.34175.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410291823.34175.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 06:23:34PM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> On 2.6.10-rc1-mm2 with SuSE 9.1 /x86_64 konqueror always crashes for no 
> specific reason and the following messages appear in dmesg:
> 
> local[18494]: segfault at 0000003000000018 rip 0000000000428f2a rsp 
> 0000007fbfffe870 error 4
> local[18493]: segfault at 0000003000000018 rip 0000000000428f2a rsp 
> 0000007fbfffe870 error 4
> 
> This does not happen on 2.6.10-rc1.

I tested this now too and konqueror also works fine for me.

-Andi
