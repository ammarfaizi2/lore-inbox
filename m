Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVDDX6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVDDX6t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVDDX6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:58:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17794 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261492AbVDDXy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:54:57 -0400
Date: Tue, 5 Apr 2005 00:54:55 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc2
Message-ID: <20050404235455.GC8859@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org> <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org> <20050404232419.GA8859@parcelfarce.linux.theplanet.co.uk> <20050405004955.A4370@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405004955.A4370@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 12:49:55AM +0100, Russell King wrote:
> IOW, when sysdev.h is updated to prototype the function pointer with
> pm_message_t, this'll also be solved.
> 
> Therefore, if anything, linux/pm.h should be added to linux/sysdev.h as
> the minimal patch.

OK...
