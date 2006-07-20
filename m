Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWGTSc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWGTSc1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 14:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWGTSc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 14:32:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:56023 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750861AbWGTSc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 14:32:26 -0400
Subject: Re: XFS Raid on Apple PowerMac G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ludovic RESLINGER <lr@cuivres.net>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060720112923.GD21541@bach>
References: <20060720100313.GC21541@bach>
	 <Pine.LNX.4.61.0607201255520.2633@yvahk01.tjqt.qr>
	 <20060720112923.GD21541@bach>
Content-Type: text/plain
Date: Thu, 20 Jul 2006 14:31:57 -0400
Message-Id: <1153420317.16159.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't know if it is a XFS-specific problem, I might test with another
> files system.
> In fact, I think this is a problem of RAID with Apple Partition Map.

I remember reading something about it a while ago... can't remember the
details but I think it was possible. At worst, an option is to use a
different partition map and boot the kernel from a USB stick :)

Ben.


