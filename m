Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132731AbRC2OOu>; Thu, 29 Mar 2001 09:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132732AbRC2OOk>; Thu, 29 Mar 2001 09:14:40 -0500
Received: from www.ansp.br ([143.108.25.7]:45576 "HELO www.ansp.br")
	by vger.kernel.org with SMTP id <S132731AbRC2OO1>;
	Thu, 29 Mar 2001 09:14:27 -0500
Message-ID: <3AC3430F.B2A87DB8@ansp.br>
Date: Thu, 29 Mar 2001 11:13:36 -0300
From: Marcus Ramos <marcus@ansp.br>
Organization: Fapesp
X-Mailer: Mozilla 4.73 [en] (X11; I; FreeBSD 4.1-RELEASE i386)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, juan@ansp.br
Subject: Re: Can't find modules after moving to 2.4.2
In-Reply-To: <3AC24E42.7CAB822A@ansp.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for those who replied telling me to upgrade modutils to 2.4.5.

I downloaded modutils-2.4.5.tar.gz and placed it in my /root directory. After
tar -xzvf, I got a new directory /root/modutils-2.4.5. Then I followed the
instructions in INSTALL:

cd modutils-2.4.5
./configure

But, from this point on, I wasn't able to finish the installation. What is
meant by "/paht/to/master/modutils/configure" ? Anyway, doing "make install"
doesn't cause any effect, as my modules still aren't loaded when I reboot
with kernel 2.4.2. Thanks in advance for your comments.

Best Regards,
Marcus.

Marcus Ramos wrote:

> Hello,
>
> I've moved from kernel 2.2.16 to 2.4.2 (RH7) and its boots OK, except
> for the fact that none of the modules in "/etc/modules.conf" are loaded
> anymore (although modules were enabled in kernel config). In
> "/lib/modules" I see two directories: 2.2.16 and 2.4.2 (which I assume
> is the default for modules.conf). However, the "/lib/modules/2.4.2"
> contains almost no files, differently from 2.2.16. I guess I've missed
> some important step during the installation of 2.4.2, but now I am
> confused and can't recover. Can anyboy point me what the missing step is
> ? I will be most grateful.
>
> Thanks in advance,
> Marcus.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

