Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266487AbUH1Dur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266487AbUH1Dur (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 23:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266491AbUH1Duq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 23:50:46 -0400
Received: from 213-229-38-18.static.adsl-line.inode.at ([213.229.38.18]:30414
	"HELO home.winischhofer.net") by vger.kernel.org with SMTP
	id S266487AbUH1Du3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 23:50:29 -0400
Message-ID: <413000EF.4070800@winischhofer.net>
Date: Sat, 28 Aug 2004 05:50:07 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6.8 pwc patches and counterpatches
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > On Fri, 2004-08-27 at 09:13, Prakash K. Cheemplavam wrote:
 > > >On Fri, 27 Aug 2004, Denis Vlasenko wrote:
 >
 > > > If the maintainer wants it pulled, I feel it would be stealing to
 > > > add it back into the kernel without his approval. Perhaps we could
 > > > rewrite the driver and merge it with some other webcam driver
 > > > projects.
 > >
 > >
 > > This is the problem. It is far easier to _feel_ something
 > > than to _do_ something.
 > >
 > > Intersting, that in the legal case, people are having a bad feeling,
 > > but in illegal case of doing reverse-engineering, drivers make it
 > > into the kernel...
 >
 >
 >Reverse engineering for interoperability purposes is legal even in the
 >USA.

Thank you for pointing that out. Really. I mean it.

And nothing else it is.

Happy hacking.

IDA anyone? (objdump does nicely, too. I looked at the disassembler 
output for about one hour today and my conclusion is that it's a pretty 
simple job. Knowing the stack concept and the "mov", "call", "lea", 
"add", "sub", "xor", "sar" and "sh[l|r]" instructions is enough.)

I would do it if I just had the time.

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org
