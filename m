Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263673AbUECM6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263673AbUECM6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 08:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbUECM6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 08:58:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22678 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263673AbUECM6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 08:58:11 -0400
Date: Mon, 3 May 2004 14:58:10 +0200
From: Jan Kara <jack@suse.cz>
To: FabF <Fabian.Frederick@skynet.be>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS 2.6.6-rc2] quota / sda1
Message-ID: <20040503125810.GG20593@atrey.karlin.mff.cuni.cz>
References: <1083447548.6718.12.camel@bluerhyme.real3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083447548.6718.12.camel@bluerhyme.real3>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

>        Using quota v2 / Linux 2.6.6-rc2 on usb storage, I've got
> following results :
 <snip>

> It appears on both ext2/ext3 and should be scsi (emulation) relevant
> only...
> 
> I tried adding usrquota in fstab after boot.It works perfectly...
  I don't quite understand your remark. You mean that without quota
option it worked perfectly? That would be strange because the errors
seem to be in a scsi layer..

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
