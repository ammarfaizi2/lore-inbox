Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288821AbSA2RS4>; Tue, 29 Jan 2002 12:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289768AbSA2RSs>; Tue, 29 Jan 2002 12:18:48 -0500
Received: from port-213-20-128-35.reverse.qdsl-home.de ([213.20.128.35]:52491
	"EHLO drocklinux.dyndns.org") by vger.kernel.org with ESMTP
	id <S288821AbSA2RSe> convert rfc822-to-8bit; Tue, 29 Jan 2002 12:18:34 -0500
Date: Tue, 29 Jan 2002 18:17:25 +0100 (CET)
Message-Id: <20020129.181725.596534475.rene.rebe@gmx.net>
To: pgallen@randomlogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon Optimization Problem
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <3C56D62D.595EA80D@randomlogic.com>
In-Reply-To: <E16VIKU-0001f7-00@the-village.bc.nu>
	<3C56D62D.595EA80D@randomlogic.com>
X-Mailer: Mew version 2.1 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On: Tue, 29 Jan 2002 09:04:45 -0800,
    "Paul G. Allen" <pgallen@randomlogic.com> wrote:
> FWIW, I've been compiling kernels since 2.4.8 with Athlon optimizations
> and have not had a problem with them. This is on a Tyan Thunder K7.
> 
> PGA

I have also compiled every kernel with Athlon optimization since
2.3.<whatever> but I have no Via boards! Irongates and SiS-735 are in
use here ... No problem! - The only problem is this box of a friend
... - which seems to be a Linux on Via hardware issue ... (Or a
general stupid Via hardware issue ...)

> Alan Cox wrote:
> > 
> > Im still not convinced touching the register on the 266 chipset at 0x95 is
> > correct. I now have several reports of boxes that only work if you leave it
> > alone
> > 
> > Alan
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> Paul G. Allen
> Owner, Sr. Engineer, Security Specialist
> Random Logic/Dream Park
> www.randomlogic.com


k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://drocklinux.dyndns.org/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
