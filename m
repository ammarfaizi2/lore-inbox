Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130694AbRBIVOh>; Fri, 9 Feb 2001 16:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130737AbRBIVO1>; Fri, 9 Feb 2001 16:14:27 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:58542 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S130694AbRBIVOP>;
	Fri, 9 Feb 2001 16:14:15 -0500
Message-ID: <3A845D34.99CCAD3B@itwm.uni-kl.de>
Date: Fri, 09 Feb 2001 22:12:20 +0100
From: braun@itwm.fhg.de
Organization: ITWM e. V.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: No sound on GA-7ZX (2.4.1-ac6, via audio)
In-Reply-To: <3A82F427.916F8F0C@itwm.fhg.de> <20010209182509.A11435@emma1.emma.line.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> 
> On Thu, 08 Feb 2001, Martin Braun wrote:
> 
> > I can not get sound working on a computer with a Gigabyte
> > GA-7ZX mainboard (KT133 chipset). Is this a known problem?
> 
> "Works for me" on 7ZXR, 2.2.18, ens1371 driver. R == additional Promise
> PDC20265R

Thanks for the info. Unfortunately the es1371 module from 2.4.1ac6 does
not work for me either. I will try downgrading next monday.

Martin Braun
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
