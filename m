Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbVIARH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbVIARH4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 13:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbVIARH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 13:07:56 -0400
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:26031 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S1030246AbVIARHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 13:07:55 -0400
Date: Thu, 1 Sep 2005 19:07:51 +0200
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Swap areas lose their signatures after reboot
Message-Id: <20050901190751.4c96bb77.Christoph.Pleger@uni-dortmund.de>
In-Reply-To: <20050831185604.GF703@openzaurus.ucw.cz>
References: <20050830142615.12910b57.Christoph.Pleger@uni-dortmund.de>
	<20050831185604.GF703@openzaurus.ucw.cz>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-sun-solaris2.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


> swsusp plays with them... Are you using swsusp?

I am not using swsusp.

I found out that as I had alredy guessed the swap signature
("SWAPSPACE2" at address 0xFF6 of the swap partition) has been deleted
after a reboot.


Christoph
