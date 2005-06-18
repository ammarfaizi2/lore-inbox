Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVFTGBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVFTGBc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 02:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVFTGBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 02:01:32 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:62468 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261455AbVFTGBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 02:01:31 -0400
Date: Sat, 18 Jun 2005 16:51:25 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Daniele Gaffuri" <d.gaffuri@reply.it>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Hidden SMBus bridge on Toshiba Tecra M2
Message-Id: <20050618165125.08db4156.khali@linux-fr.org>
In-Reply-To: <TO1FRES03vZXqimrMh000004695@to1fres03.replynet.prv>
References: <20050617224953.GA23742@suse.de>
	<TO1FRES03vZXqimrMh000004695@to1fres03.replynet.prv>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniele,

> Trivial patch, against 2.6.12-rc6, to unhide SMBus on Toshiba Centrino
> laptops using Intel 82855PM chipset

Looks good, I pushed it onto my current stack of patches.

Thanks,
-- 
Jean Delvare
