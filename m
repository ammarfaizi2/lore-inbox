Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264913AbSIWCeu>; Sun, 22 Sep 2002 22:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264918AbSIWCeu>; Sun, 22 Sep 2002 22:34:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61202 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264913AbSIWCer>;
	Sun, 22 Sep 2002 22:34:47 -0400
Message-ID: <3D8E7EDD.7020405@mandrakesoft.com>
Date: Sun, 22 Sep 2002 22:39:25 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Peter Rival <frival@zk3.dec.com>, Jochen Friedrich <jochen@scram.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.38
References: <Pine.LNX.4.44.0209221930560.1208-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Sun, 22 Sep 2002, Peter Rival wrote:
> 
>>Patch below fixes the problem.  Linus, please apply.  Here's hoping Mozilla
>>doesn't blow up the patch
> 
> 
> It does (or something else does) - tabs have been space'ified.
> 
> What the hell is _wrong_ with mail client authors that they can't get
> something as simple as keeping a file intact _correct_? Why do email
> clients think they have to corrupt the input on something as simple as
> plain 7-bit ascii (oe even 8-bit latin1, for that matter)? Silly buggers.


I've been sending patches via Netscape Mail and Mozilla Mail for 
years...  inline has never ever worked, but attachments always work[1]. 
  And if the attachments are detected to be text by the internal magic, 
the attachments are properly marked text/plain and sent cleartext...

So, attach patches and make sure the patches don't have binary crud in 
them, and you're fine.

	Jeff


[1] always being defined as 99% not 100% ;-)

