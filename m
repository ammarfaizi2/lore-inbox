Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUH0IFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUH0IFO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 04:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUH0IFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 04:05:13 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:9116 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265091AbUH0IFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:05:05 -0400
Message-ID: <412EEB2E.1020100@namesys.com>
Date: Fri, 27 Aug 2004 01:05:02 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>
CC: Spam <spam@tnonline.net>, Wichert Akkerman <wichert@wiggy.net>,
       Christer Weinigel <christer@weinigel.se>, Andrew Morton <akpm@osdl.org>,
       jra@samba.org, torvalds@osdl.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>	 <1453698131.20040826011935@tnonline.net>	 <20040825163225.4441cfdd.akpm@osdl.org>	 <20040825233739.GP10907@legion.cup.hp.com>	 <20040825234629.GF2612@wiggy.net> <1939276887.20040826114028@tnonline.net>	 <20040826024956.08b66b46.akpm@osdl.org>	 <839984491.20040826122025@tnonline.net> <m3llg2m9o0.fsf@zoo.weinigel.se>	 <1906433242.20040826133511@tnonline.net> <20040826113332.GL2612@wiggy.net>	 <1211039639.20040826134354@tnonline.net> <1093592467.18603.6.camel@tara.firmix.at>
In-Reply-To: <1093592467.18603.6.camel@tara.firmix.at>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch wrote:

>On Thu, 2004-08-26 at 13:43 +0200, Spam wrote:
>  
>
>>>Previously Spam wrote:
>>>      
>>>
>>>>  How  so?  The whole idea is that the underlaying OS that handles the
>>>>  copying  should  also  know  to  copy  everything, otherwise you can
>>>>  implement  everything  into  applications  and  just  skip the whole
>>>>  filesystem part.
>>>>        
>>>>
>>>UNIX doesn't have a copy systemcall, applications copy the data
>>>manually.
>>>      
>>>
>>  Oh, this is very unfortunate and should be a bigger issue to fix.
>>    
>>
>
>Then you have to rewrite POSIX und SuSv3.
>
>	Bernd
>  
>
Spam is right.  Posix is a standard, not a vision, and the future is 
always a vision not a standard.
