Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268708AbUH3Rvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268708AbUH3Rvt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268682AbUH3Ror
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:44:47 -0400
Received: from ms-smtp-04.rdc-kc.rr.com ([24.94.166.116]:3734 "EHLO
	ms-smtp-04.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S268677AbUH3RoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:44:20 -0400
Date: Mon, 30 Aug 2004 12:42:25 -0500
From: Andy Warner <andyw@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [patch] libata: add ioctls to support SMART
Message-ID: <20040830124225.A4358@florence.linkmargin.com>
References: <200408301531.i7UFVBg29089@ra.tuxdriver.com> <413361BF.8020805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <413361BF.8020805@pobox.com>; from jgarzik@pobox.com on Mon, Aug 30, 2004 at 01:19:59PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> [...]
> That implies, then, that you would add code to libata-scsi.c that 
> translates the ATA-passthru SCSI command into an ATA command using the 
> ata_scsi_translate() infrastructure.

Speaking of which - I'm working on this and want to find like
minded people playing in the libata-scsi.c/04-262r<n>.pdf
sandbox, and collaborate with them.

If you're one of these people, ping me off list and we
can pool our efforts.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
