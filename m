Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTDXTDd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 15:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTDXTDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 15:03:33 -0400
Received: from watch.techsource.com ([209.208.48.130]:52220 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S263823AbTDXTDc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 15:03:32 -0400
Message-ID: <3EA83BBA.5060502@techsource.com>
Date: Thu, 24 Apr 2003 15:32:10 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Linus Torvalds <torvalds@transmeta.com>, John Bradford <john@grabjohn.com>,
       Jamie Lokier <jamie@shareable.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
References: <Pine.LNX.4.44.0304240741530.20549-100000@home.transmeta.com> <20030424190207.319431257A9@mx12.arcor-online.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Daniel Phillips wrote:

>On Thu 24 Apr 03 16:45, Linus Torvalds wrote:
>  
>
>>If open hardware is what you want, FPGA's are actually getting to the
>>point where you can do real CPU's with them. They won't be gigahertz, and
>>they won't have big nice caches (but hey, you might make something that
>>clocks fairly close to memory speeds, so you might not care about the
>>latter once you have the former).
>>
>>They're even getting reasonably cheap.
>>    
>>
>
>The big problem with FPGAs at the moment is that the vendors want you to use 
>their tools, which come with license agreements that limit your options in 
>arbitrary ways, otherwise this would be peachy.
>
>
>  
>
For their smaller devices, Xilinx has a free "WebPack" which is a 
complete Verilog synthesizer (I don't know if it does VHDL), as well as 
place & route, of course.  I think it'll do up to Virtex II 250.  It 
also tends use fewer gates for a given design than the version of 
Leonardo Spectrum we have.  It just doesn't have a simulator, which is 
vital to any good development process.  Also, the Web Pack only runs 
under Windows.  Maybe it'll work with WINE?

I've been working on my own 32-bit CPU design for FPGA lately.  Maybe we 
can get Linux to run on it.  :)


