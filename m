Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132559AbRCZTxD>; Mon, 26 Mar 2001 14:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132571AbRCZTwx>; Mon, 26 Mar 2001 14:52:53 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:24448 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132564AbRCZTwu>;
	Mon, 26 Mar 2001 14:52:50 -0500
Message-ID: <3ABF9DE7.48458988@mandrakesoft.com>
Date: Mon, 26 Mar 2001 14:52:07 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net, cort@fsmlabs.com
Subject: Re: CML1 cleanup patch, take 2
In-Reply-To: <200103260955.f2Q9tfo14568@snark.thyrsus.com> <3ABF574D.65CBD22@mandrakesoft.com> <20010326081157.H16672@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Mon, Mar 26, 2001 at 09:50:53AM -0500, Jeff Garzik wrote:
> > PPC guys:  this is a gratuitous renaming change that is not required.
> > If you have been following the "CML1 cleanup patch" thread, you see that
> > Eric is blindly dictating policy when he says that CONFIG_[0-9] needs to
> > be cleaned up.

> The counter point to this is what does "CONFIG_6xx" or 8xx mean?  It's as bad
> as CONFIG_Mxxx imho :)

No argument.. :)  I definitely encourage namespace cleanup in 2.5 -- but
please don't change an identifier just because it begins with a numeric
prefix...  Change it because it needs to be changed.

Best regards,

	Jeff


-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
