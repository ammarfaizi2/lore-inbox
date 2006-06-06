Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWFFRAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWFFRAW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 13:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWFFRAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 13:00:21 -0400
Received: from mx11.sac.fedex.com ([199.81.193.118]:62986 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP id S1750747AbWFFRAV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 13:00:21 -0400
Date: Wed, 7 Jun 2006 01:03:22 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@indiana.corp.fedex.com
To: Linus Torvalds <torvalds@osdl.org>, randy_d_dunlap@linux.intel.com
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.17-rc6
In-Reply-To: <Pine.LNX.4.64.0606051807310.5498@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0606070053530.10051@indiana.corp.fedex.com>
References: <Pine.LNX.4.64.0606051807310.5498@g5.osdl.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 06/07/2006
 01:00:15 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 06/07/2006
 01:00:17 AM,
	Serialize complete at 06/07/2006 01:00:17 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Jun 2006, Linus Torvalds wrote:

> ... a SATA resume fix that is reported to fix resume on at least a 
> couple of machines.

Thank you. This works on my IBM X60s with Centrino Duo. Pure vanilla 
2.6.17-rc6, no other patches necessary.

Works with ata-piix, but not ahci.


Jeff.


