Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310214AbSDMTgo>; Sat, 13 Apr 2002 15:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310224AbSDMTgn>; Sat, 13 Apr 2002 15:36:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46343 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310214AbSDMTgm>; Sat, 13 Apr 2002 15:36:42 -0400
Message-ID: <3CB888B6.3090800@zytor.com>
Date: Sat, 13 Apr 2002 12:36:22 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020312
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
In-Reply-To: <E16wTYq-00014P-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>Oh yes, but the *expensive* part of the machine -- the multiprocessor 
>>box -- isn't.
> 
> If you need SMP (frequently doubtful) its a price, but dual celeron and
> dual duron are cheap if you buy them from sensible vendors.
> 
>>Also, when using massmarket systems of more than 2 or 3 monitors you 
>>start having cabling problems.  VGA connectors aren't impedance matched 
>>and cause nasty reflections at high resolutions, so they don't extend 
>>well.  I guess digital video is coming, but is not yet mass market.
> 
> Indeed and most of it is not specced for long distances. It will also no
> doubt be held up even more now the encryption on the wire wants to be augmented
> by the newer watermarking stuff so the monitor won't show movies without
> authorization
> 

If you're talking about things like setting up multiheaded UP and 
dual-processor machines for, say, an undergraduate lab in a university, 
then I think you're probably on the right track -- *especially* if the 
alternative would be using X-terminals (gack!!!) to leech the CPU power 
anyway.

Otherwise, I think that's probably the main "minicomputeresque" form of 
Linux usage -- remote X display.

	-hpa



