Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130836AbRADSUu>; Thu, 4 Jan 2001 13:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131541AbRADSUk>; Thu, 4 Jan 2001 13:20:40 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:1683 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S130983AbRADSU1>; Thu, 4 Jan 2001 13:20:27 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Mo McKinlay <mmckinlay@gnu.org>
Cc: Chris Wedgwood <cw@f00f.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Phillips <phillips@innominate.de>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Date: Thu, 4 Jan 2001 10:19:58 -0800 (PST)
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <Pine.LNX.4.30.0101041813310.967-100000@nvws005.nv.london>
Message-ID: <Pine.LNX.4.31.0101041018430.10387-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Mo McKinlay wrote:

>   > The off button need not and _does not_ remove power instantly (if at
>   > all) on many appliances.
>
> Indeed - but unplugging your VCR from the wall won't harm it. Everyone
> knows the power button on a TV/VCR/etc doesn't actually kill the power,
> just reduce consumption (i.e., standby mode). But unplugging it at the
> wall doesn't have any detrimental effects - doing that to a PC will.

if you change that statement to "usually won't harm it" I agree with you
(I have had a VCR eat a tape when this was done)

David Lang


> Being able to change what the power button does is cool, but it does mask
> the real issue - what happens when you pull the plug, and how do you make
> it so that it's acceptable?
>
> --
> Mo McKinlay
> mmckinlay@gnu.org
> -------------------------------------------------------------------------
> GnuPG/PGP Key: pub  1024D/76A275F9 2000-07-22
>
>
>
>
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
