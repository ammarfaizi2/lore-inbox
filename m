Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267107AbRGJTR5>; Tue, 10 Jul 2001 15:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267106AbRGJTRt>; Tue, 10 Jul 2001 15:17:49 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:42204 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S267108AbRGJTRi>;
	Tue, 10 Jul 2001 15:17:38 -0400
Message-ID: <3B4B54D2.9A81EDDD@mandrakesoft.com>
Date: Tue, 10 Jul 2001 15:17:38 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Konstantin Volckov <goldhead@altlinux.ru>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Edward Peng." <edward_peng@dlink.com.tw>
Subject: Re: PATCH for dl2k driver
In-Reply-To: <20010710222417.26dedb99.goldhead@altlinux.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Volckov wrote:
> There is a mistake in dl2k.c network driver added in 2.4.6-ac2.

I doubt you have hardware for it, so no big deal ;-)


> Without this patch gcc-2.95.3 produces a broken symbol __ucmpdi2, while
> gcc-2.96 works ok.

Alan please do not apply, there is a better update coming your way,
including other bug fixes as well.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
