Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289750AbSA2RFp>; Tue, 29 Jan 2002 12:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289764AbSA2RFe>; Tue, 29 Jan 2002 12:05:34 -0500
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:35639 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S289750AbSA2RFW>; Tue, 29 Jan 2002 12:05:22 -0500
Message-ID: <3C56D62D.595EA80D@randomlogic.com>
Date: Tue, 29 Jan 2002 09:04:45 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Random Logic
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Athlon Optimization Problem
In-Reply-To: <E16VIKU-0001f7-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, I've been compiling kernels since 2.4.8 with Athlon optimizations
and have not had a problem with them. This is on a Tyan Thunder K7.

PGA

Alan Cox wrote:
> 
> Im still not convinced touching the register on the 266 chipset at 0x95 is
> correct. I now have several reports of boxes that only work if you leave it
> alone
> 
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Paul G. Allen
Owner, Sr. Engineer, Security Specialist
Random Logic/Dream Park
www.randomlogic.com
