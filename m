Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUCCElu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUCCEls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:41:48 -0500
Received: from havoc.gtf.org ([216.162.42.101]:50406 "EHLO gtf.org")
	by vger.kernel.org with ESMTP id S262383AbUCCEl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:41:29 -0500
Date: Tue, 2 Mar 2004 23:41:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE cleanups for 2.6.4-rc1 (2/3)
Message-ID: <20040303044125.GA12722@havoc.gtf.org>
References: <200403022215.07385.bzolnier@elka.pw.edu.pl> <404513E8.9010101@pobox.com> <200403030538.10029.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403030538.10029.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 05:38:10AM +0100, Bartlomiej Zolnierkiewicz wrote:
> Please note that any attempts to verify commands (like this 'switch')
> will fail for future or vendor specific ones.

Oh, agreed.  Userspace definitely needs to be the one passing in the 
phase information...  my response was related to the fact that I thought
the switch was required, because userspace did not provide that info.

	Jeff



