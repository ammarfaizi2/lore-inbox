Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268784AbVBETdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268784AbVBETdy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 14:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268568AbVBETdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 14:33:54 -0500
Received: from smtp.nuvox.net ([64.89.70.9]:17874 "EHLO
	smtp05.gnvlscdb.sys.nuvox.net") by vger.kernel.org with ESMTP
	id S273629AbVBETdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 14:33:42 -0500
Subject: Re: [Patch] eth1394: Change KERN_ERR to KERN_INFO
From: Dan Dennedy <dan@dennedy.org>
To: Jody McIntyre <scjody@modernduck.com>
Cc: Steffen Zieger <lkml@steffenspage.de>, linux-kernel@vger.kernel.org,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>
In-Reply-To: <20050204190035.GG21958@conscoop.ottawa.on.ca>
References: <200502031528.51523.lkml@steffenspage.de>
	 <20050204190035.GG21958@conscoop.ottawa.on.ca>
Content-Type: text/plain
Date: Sat, 05 Feb 2005 14:26:52 -0500
Message-Id: <1107631612.5088.8.camel@kino.dennedy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Committed

On Fri, 2005-02-04 at 14:00 -0500, Jody McIntyre wrote:
> Change the initialization message for eth1394 to KERN_INFO, requested
> by
> Steffen Zieger <lkml@steffenspage.de>
> 
> Signed-off-by: Jody McIntyre <scjody@modernduck.com>

