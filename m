Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTLVVYp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 16:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbTLVVYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 16:24:45 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:8086 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264479AbTLVVYF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 16:24:05 -0500
Date: Mon, 22 Dec 2003 13:23:44 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Merge more VM from 2.4-aa? was: Linux 2.4.24-pre2
Message-ID: <20031222212344.GS6438@matchmail.com>
Mail-Followup-To: Xose Vazquez Perez <xose@wanadoo.es>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3FE759A4.50208@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE759A4.50208@wanadoo.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 09:52:52PM +0100, Xose Vazquez Perez wrote:
> Mike Fedyk wrote:
> 
> > Do you plan on merging any more of the VM from Andrea in this release (or
> > future releases)?
> 
> Andrea said [1] that there are two patches missing: inode-highmem and
> related_bhs
> But he is not going to work on it for 2.4
> 
> [1] http://marc.theaimsgroup.com/?l=linux-kernel&m=107048611507709&w=2

Yes, I read this one when it was posted, but forgot the details.  It seems
that inode-highmem is relatively self contained though.
