Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVFKSrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVFKSrw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 14:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVFKSrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 14:47:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32900 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261768AbVFKSrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 14:47:51 -0400
Date: Sat, 11 Jun 2005 19:47:46 +0100
From: jgarzik@pentafluge.infradead.org
To: Robert White <rwhite@casabyte.com>
Cc: "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'Kumar Gala'" <kumar.gala@freescale.com>,
       "'Linux Kernel list'" <linux-kernel@vger.kernel.org>
Subject: Re: stupid SATA questions
Message-ID: <20050611184746.GC3019@pentafluge.infradead.org>
References: <42A72E4F.4040700@pobox.com> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAujDVGqnqiEuiX8MD6j5uVwEAAAAA@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAujDVGqnqiEuiX8MD6j5uVwEAAAAA@casabyte.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 11:51:26AM -0700, Robert White wrote:
> I cannot find the ATA passthru or SMART option in the 2.6.11.10 kernel anywhere near
> the SCSI or ATA .  Is it somewhere obscure, has it been renamed, or am I looking in
> totally the wrong place? (e.g. is this an option when building hdparm or something?)

It requires an additional patch; it has not been mergedsinceit still
has a few problems.

	Jeff


