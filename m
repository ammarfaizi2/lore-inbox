Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbSJTPqg>; Sun, 20 Oct 2002 11:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263135AbSJTPqg>; Sun, 20 Oct 2002 11:46:36 -0400
Received: from host194.steeleye.com ([66.206.164.34]:26636 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S263039AbSJTPqf>; Sun, 20 Oct 2002 11:46:35 -0400
Message-Id: <200210201552.g9KFqZv11487@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re: AIC7xxx driver build failure
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 Oct 2002 10:52:35 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, because this bug doesn't exist in the latest version of the driver
> in my tree or the last set of patches I sent to Linus (a month ago??).

I think I missed this on linux-scsi.  However, there have been some fairly 
major scsi fixes which necessitated changes to your driver (among others) so 
it could be that the patches now reject.  Could you rebase to 2.5.44 and 
resend to linux-scsi (or just post a URL, if that's easier)?

Thanks,

James





