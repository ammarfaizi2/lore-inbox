Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267429AbTAGR3Y>; Tue, 7 Jan 2003 12:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbTAGR3Y>; Tue, 7 Jan 2003 12:29:24 -0500
Received: from zeke.inet.com ([199.171.211.198]:39390 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S267429AbTAGR3X>;
	Tue, 7 Jan 2003 12:29:23 -0500
Message-ID: <3E1B1074.5030806@inet.com>
Date: Tue, 07 Jan 2003 11:37:56 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC] Documentation/kbuild/makefiles.txt
References: <20030105215137.GA3659@mars.ravnborg.org> <Pine.LNX.4.33L2.0301051619210.13623-100000@dragon.pdx.osdl.net> <20030106193651.GA1320@mars.ravnborg.org> <20030107165624.GA1222@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
[snip]
> --- 4.2 Composite Host Programs
> 
> 	Host programs can be made up based on composite objects.
> 	The syntax used to define composite objetcs for host programs is
> 	similar to the syntax used for kernel objects.
> 	$(<executeable>-objs) list all objects used to link the final
> 	executable.
> 
> 	Example:
> 		#scripts/lxdialog/Makefile
> 		host-progs   := lxdialog  
> 		hex2bin-objs := checklist.o lxdialog.o
[snip]

You mean s/hex2bin/lxdialog/ right?

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

