Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272805AbRIGSLc>; Fri, 7 Sep 2001 14:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272806AbRIGSLV>; Fri, 7 Sep 2001 14:11:21 -0400
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:28552 "EHLO
	k-7.stesmi.com") by vger.kernel.org with ESMTP id <S272805AbRIGSLJ>;
	Fri, 7 Sep 2001 14:11:09 -0400
Message-ID: <3B990D50.3060101@stesmi.com>
Date: Fri, 07 Sep 2001 20:09:20 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: ejolson@math.uci.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: Some experiences with the Athlon optimisation problem
In-Reply-To: <200109071718.KAA03472@math.uci.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

 >>The old Athlon reads:
 >>       A1133AMS3C
 >>       AVIA 0115TPAW
 >>       95262550081
 >>
 >>The new (non working) one:
 >>       A1200AMS3C
 >>       AXIA 0121RPDW
 >>       95987660990
 >>
 >
 > The first line can be decoded using AMDs documentation at
 >
 >     http://www.amd.com/products/cpg/athlon/techdocs/index.html
 >
 > In particular

<snip>

 > Anyone know what the second line means?  It is quite mysterious
 > that the word VIA appears on the chip that works with VIA KT133A
 > and not on the other :-)

The first letters, be they 4, 5 or 6 or whatever is stepping.

So the old is AVIA stepping, the new is the AXIA stepping.

The nextcoming four numbers are production week, ie 2001 week 15 and 
2001 week 21. I can't remember the letters.

// Stefan

