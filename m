Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTDYPJF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 11:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263328AbTDYPJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 11:09:05 -0400
Received: from watch.techsource.com ([209.208.48.130]:53244 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S263319AbTDYPJC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 11:09:02 -0400
Message-ID: <3EA9565B.9020905@techsource.com>
Date: Fri, 25 Apr 2003 11:38:03 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Augart <steve@augart.com>
CC: John Bradford <john@grabjohn.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Simple x86 Simulator (was: Re: Flame Linus to a crisp!)
References: <200304250702.h3P72FZF000352@81-2-122-30.bradfords.org.uk> <3EA8EC4D.4090506@augart.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Steven Augart wrote:

> We could not.  Consider just the 8 32-bit-wide legacy x86 registers, 
> excluding the MMX and FPU registers:
> (AX, BX, CX, DX, BP, SI, DI, SP).  32 bits x 8 = 2^256 independent 
> states to look up in the table, each state having 256 bits of 
> information.  2^264 total bits of information needed.  Assume 1 GB 
> dimms (2^30 * 8 bits each = 2^33 bits of info), with a volume of 10 
> cm^3 per DIMM (including a tiny amount of space for air circulation.).
> Need 34508731733952818937173779311385127262255544860851932776 cubic 
> kilometers of space.
>
> Considerably larger than the volume of the earth, although admittedly 
> smaller than the total volume of the universe.
> --Steven Augart
>
>

If this could be done, someone would have done it already.


