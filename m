Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267178AbSK2Xae>; Fri, 29 Nov 2002 18:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267179AbSK2Xae>; Fri, 29 Nov 2002 18:30:34 -0500
Received: from pcp748446pcs.manass01.va.comcast.net ([68.49.120.237]:50142
	"EHLO pcp748343pcs.manass01.va.comcast.net") by vger.kernel.org
	with ESMTP id <S267178AbSK2Xad>; Fri, 29 Nov 2002 18:30:33 -0500
Date: Fri, 29 Nov 2002 18:37:51 -0500
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.49 hanging at boot
Message-ID: <20021129233751.GA9751@bittwiddlers.com>
References: <20021123113215.V20474-200000@freebsd.rf0.com> <20021123142916.GA18127@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021123142916.GA18127@bittwiddlers.com>
User-Agent: Mutt/1.4i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.62
Reply-To: Matthew Harrell 
	  <mharrell-dated-1039045072.8439bc@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BTW, this problem still exists in 2.5.50.  I get the booting message and then 
the screen goes blank and the system hangs forcing a hard reset.  Everything
worked fine in kernel versions before 2.5.49 with the same config


>> Hi All,
>> I've just tried to goto 2.5.49 and its hanging at
>> 
>> Uncompressing Kernel...Booting Linux
>> 
>> I've checked that I'm using the correct CPU's and SMP is enabled.
>> 
>> My machine spec is
>> 
>> Dual 2000+ Athlon MP
>> 512 MB ECC memory
>> 
>> I've attached my .config. I tried a distclean and mrproper but both
>> failed. Any ideas?
> 
> I get the same thing on my laptop - Pentium 4, 1.5GHz, acpi.
> 
> I attached my config below too

-- 
  Matthew Harrell                          Quantum Mechanics:
  Bit Twiddlers, Inc.                       The dreams stuff is made of.
  mharrell@bittwiddlers.com     
