Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135767AbRD0KSb>; Fri, 27 Apr 2001 06:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135801AbRD0KSU>; Fri, 27 Apr 2001 06:18:20 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:50192 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S135767AbRD0KSH>;
	Fri, 27 Apr 2001 06:18:07 -0400
Date: Fri, 27 Apr 2001 12:17:58 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: dave.fraser@baesystems.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resetting a PCI device
Message-ID: <20010427121758.A28746@se1.cogenit.fr>
In-Reply-To: <001901c0ceff$c0ae88e0$64ccdd89@edinbr.gmav.gecm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001901c0ceff$c0ae88e0$64ccdd89@edinbr.gmav.gecm.com>; from dave.fraser@baesystems.com on Fri, Apr 27, 2001 at 10:52:20AM +0100
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dave.fraser@baesystems.com <dave.fraser@baesystems.com> ecrit :
> Is there any way of issuing a PCI reset (safely) without rebooting?  I am

No.

[...]
> without having to go through the hassle of a reboot.  Is this wishful
> thinking?

Yes. Try to narrow the circunstances under which the device locks and avoid
them at all cost is the best to be done.

-- 
Ueimor
