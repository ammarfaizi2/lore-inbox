Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269753AbUJVIQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269753AbUJVIQj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 04:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270079AbUJVIMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 04:12:21 -0400
Received: from mailgate1.uni-kl.de ([131.246.120.5]:30666 "EHLO
	mailgate1.uni-kl.de") by vger.kernel.org with ESMTP id S269837AbUJVIKe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 04:10:34 -0400
Date: Fri, 22 Oct 2004 10:10:31 +0200
From: Eduard Bloch <edi@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.9-rc?] long pause after IDE detection
Message-ID: <20041022081031.GA4073@zombie.inka.de>
References: <20041021220438.GA13864@zombie.inka.de> <58cb370e0410211523416be4a8@mail.gmail.com> <20041022002237.GA1948@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022002237.GA1948@kurtwerks.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Kurt Wall [Thu, Oct 21 2004, 08:22:37PM]:
> On Fri, Oct 22, 2004 at 12:23:34AM +0200, Bartlomiej Zolnierkiewicz took 8 lines to write:
> > > CONFIG_IDE_GENERIC=y
> > 
> > Does disabling this option help?
> 
> Yes.

Yes, both methods did work, thank you. And I prefer disabling the
generic driver. However, something still goes wrong in the driver.

Regards,
Eduard.
-- 
<kw> No Jolt and no Musik makes Alfie go crazy ...
