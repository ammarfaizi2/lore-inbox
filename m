Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266958AbTBCSkk>; Mon, 3 Feb 2003 13:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbTBCSkk>; Mon, 3 Feb 2003 13:40:40 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:2264 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266958AbTBCSkk>;
	Mon, 3 Feb 2003 13:40:40 -0500
Date: Mon, 03 Feb 2003 10:42:02 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mark Haverkamp <markh@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.59-mjb3 (scalability / NUMA patchset)
Message-ID: <315150000.1044297722@flay>
In-Reply-To: <1044297228.29537.5.camel@markh1.pdx.osdl.net>
References: <19270000.1038270642@flay><134580000.1039414279@titus> <32230000.1039502522@titus><568990000.1040112629@titus> <21380000.1040717475@titus> <821470000.1041579423@titus> <214500000.1041821919@titus> <676880000.1042101078@titus> <922170000.1042183282@titus> <437220000.1042531505@titus> <190030000.1042787514@titus> <19610000.1043137151@titus> <20200000.1043806571@flay>  <125620000.1044238081@[10.10.2.4]> <1044297228.29537.5.camel@markh1.pdx.osdl.net>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The patchset contains mainly scalability and NUMA stuff, and anything 
>> else that stops things from irritating me. It's meant to be pretty stable, 
>> not so much a testing ground for new stuff.
>> 
>> I'd be very interested in feedback from anyone willing to test on any 
>> platform, however large or small.
>> 
>> http://www.aracnet.com/~fletch/linux/2.5.59/patch-2.5.59-mjb3.bz2
>> 
> 
> I tried 2.5.59-mjb3 today on our 16 processor numaq and got a boot
> hang.  I had been running 2.5.59-mjb2 previously.  I have included the
> console output and my config file.   

What gcc are you using? I'm betting 3.2 ... 2.95 seems to work fine.
(still might be an issue with the patch, just trying to track it down)

M.


