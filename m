Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135714AbRDSVQX>; Thu, 19 Apr 2001 17:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135717AbRDSVQO>; Thu, 19 Apr 2001 17:16:14 -0400
Received: from t2.redhat.com ([199.183.24.243]:10493 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135714AbRDSVP5>; Thu, 19 Apr 2001 17:15:57 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200104192004.VAA01094@raistlin.arm.linux.org.uk> 
In-Reply-To: <200104192004.VAA01094@raistlin.arm.linux.org.uk> 
To: rmk@arm.linux.org.uk
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
Subject: Re: Dead symbol elimination, stage 1 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 19 Apr 2001 22:15:53 +0100
Message-ID: <22056.987714953@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rmk@arm.linux.org.uk said:
>  For instance, a quick scan of my latest ARM patch reveals: 
> src@raistlin:[2]:<1009> grep 'diff.*Config.in' rmk1
> diff -urN linux-orig/drivers/mtd/Config.in linux/drivers/mtd/Config.in

Please could you make sure that whatever changes you have are in my CVS - 
I'm working on getting ready to sync up.

--
dwmw2


