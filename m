Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269472AbUI3UHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269472AbUI3UHD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269458AbUI3UHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:07:02 -0400
Received: from lists.us.dell.com ([143.166.224.162]:42455 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S269472AbUI3UEk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:04:40 -0400
Date: Thu, 30 Sep 2004 15:04:28 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: PATCH: Kconfig for EDD
Message-ID: <20040930200428.GA7442@lists.us.dell.com>
References: <20040930175247.GA31128@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930175247.GA31128@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 01:52:47PM -0400, Alan Cox wrote:
> EDD fails with ACARD scsi devices present (hang on the 16bit bios call at boot)

Sorry, I didn't see your previous message.  Certainly fair to apply,
there are at least 2 BIOS versions by different manufacturers which
seem to have problems with this yet.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
