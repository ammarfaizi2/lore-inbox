Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263254AbUCNC2j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 21:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263256AbUCNC2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 21:28:39 -0500
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:49327 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S263254AbUCNC2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 21:28:35 -0500
Message-ID: <4053C353.6040205@blueyonder.co.uk>
Date: Sun, 14 Mar 2004 02:28:35 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: NVIDIA and 2.6.4?
References: <4053C22B.2090200@blueyonder.co.uk>
In-Reply-To: <4053C22B.2090200@blueyonder.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2004 02:28:34.0285 (UTC) FILETIME=[0C6DB1D0:01C4096C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce wrote:

> Adam Jones wrote:
> >In a futile gesture against entropy, Sid Boyce wrote:
> >>/ Max Valdez wrote:/
>
> >>/ >Been using nvidia modules for quite a few 2.6.x kernels, most of 
> them mmX. /
> >>/ >without problems/
>
> >I'm using it here with 2.6.4, no problems as yet.
>
> >>/ Something strange happened, I shall try 2.6.4-mm1 shortly to see 
> if it /
> >>/ is still the same. I reckon though that I've suffered a filesystem /
> >>/ corruption./
>
> > A quick thought - have you got CONFIG_REGPARM enabled in the kernel
> > config? If so, disable it and try again. (It's almost certain to
> > cause crashes with binary modules.)
> I haven't had CONFIG_REGPARM set in any of the kernels. 2.6.4-rc2-mm1 
> was fine until after I first booted 2.6.4-mm1, then neither would work 
> with nvidia. I also got some strange stuff happening, including 
> checksum errors on the driver and I had to download it again from 
> nvidia.com on two occasions, the first redownload reinstalled  once, 
> then  chksum errors, the second redownload did the same as well as 
> chksum segfaulting, since then it's been fine. See also the garbage I 
> get out of vi in an earlier posting.
> Regards
> Sid.
>
*** CORRECTION *** 2.6.4-rc2-mm1 is the one that caused the trouble as 
stated in the first post. I'm yet to boot up 2.6.4-mm1.
Some of the files in lost+found seem to be kde settings which I noticed 
were missing and had to setup again.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

