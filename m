Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSFNSlS>; Fri, 14 Jun 2002 14:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313505AbSFNSlS>; Fri, 14 Jun 2002 14:41:18 -0400
Received: from AGrenoble-202-1-1-27.abo.wanadoo.fr ([80.14.157.27]:57473 "EHLO
	lyon.ram.loc") by vger.kernel.org with ESMTP id <S312938AbSFNSlQ>;
	Fri, 14 Jun 2002 14:41:16 -0400
To: linux-kernel@vger.kernel.org
From: Raphael_Manfredi@pobox.com (Raphael Manfredi)
Subject: Re: The buggy APIC of the Abit BP6
Date: 14 Jun 2002 18:41:06 GMT
Organization: Home, Grenoble, France
Message-ID: <aeddc2$jva$1@lyon.ram.loc>
In-Reply-To: <004901c213c3$7a73b8f0$020da8c0@nitemare>
X-Newsreader: trn 4.0-test74 (May 26, 2000)
X-Mailer: newsgate 1.0 at lyon.ram.loc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Robbert Kouprie <robbert@radium.jvb.tudelft.nl> from ml.linux.kernel:
:BTW, did you get any explanation why this wasn't applied in -ac or main
:kernel?

None.

But I know that this patch is dirty because it attacks a hardware-dependent
layer from a rather generic one.  This may be why it's rejected.  And it
may also be completely APIC-BP6 specific.

I also know is that it works for me. ;-)

Raphael
