Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUJVTMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUJVTMX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUJVTMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:12:02 -0400
Received: from cantor.suse.de ([195.135.220.2]:38118 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266481AbUJVTLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:11:35 -0400
Date: Fri, 22 Oct 2004 21:05:50 +0200
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>, ak@suse.de,
       pavel@suse.cz
Subject: Re: [PATCH] x86_64 ia32 syscall32: references initdata during resume
Message-ID: <20041022190550.GA29633@wotan.suse.de>
References: <41795446.40904@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41795446.40904@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 11:41:10AM -0700, Randy.Dunlap wrote:

I already fixed it in my tree, thanks.

-Andi
