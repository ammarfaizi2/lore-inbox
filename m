Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265899AbTL3XQg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 18:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTL3XNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 18:13:39 -0500
Received: from linux.us.dell.com ([143.166.224.162]:32737 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S265864AbTL3XL4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 18:11:56 -0500
Date: Tue, 30 Dec 2003 17:11:43 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Samuel Flory <sflory@rackable.com>
Cc: Brad House <brad_mssw@gentoo.org>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, Atul.Mukker@lsil.com
Subject: Re: [PATCH 2.6.0] megaraid 64bit fix/cleanup (AMD64)
Message-ID: <20031230171143.A23209@lists.us.dell.com>
References: <65095.68.105.173.45.1072761027.squirrel@mail.mainstreetsoftworks.com> <20031230052041.GA7007@gtf.org> <65025.68.105.173.45.1072765590.squirrel@mail.mainstreetsoftworks.com> <3FF11CC2.7040209@pobox.com> <3FF1D567.4040205@rackable.com> <33036.209.251.159.140.1072813780.squirrel@mail.mainstreetsoftworks.com> <3FF1D7EE.5050603@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FF1D7EE.5050603@rackable.com>; from sflory@rackable.com on Tue, Dec 30, 2003 at 11:54:22AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    There is a 2.00.9 in 2.4.  In theory you should really be asking on
> linux-megaraid-devel@dell.com.

linux-megaraid-devel@dell.com is closed and gone now (only archives
remain).  megaraid driver issues should be discussed on
linux-scsi@vger.kernel.org now.  Atul had ported 2.00.6 or so to 2.6
already and posted it to linux-scsi for comment, before the hard
freeze hit; James may have newer code pending somewhere.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
