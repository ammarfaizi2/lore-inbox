Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbUCNCXp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 21:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbUCNCXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 21:23:44 -0500
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:38566 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S263250AbUCNCXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 21:23:40 -0500
Message-ID: <4053C22B.2090200@blueyonder.co.uk>
Date: Sun, 14 Mar 2004 02:23:39 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: NVIDIA and 2.6.4?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2004 02:23:39.0292 (UTC) FILETIME=[5C9955C0:01C4096B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Jones wrote:
 >In a futile gesture against entropy, Sid Boyce wrote:
 >>/ Max Valdez wrote:/

 >>/ >Been using nvidia modules for quite a few 2.6.x kernels, most of 
them mmX. /
 >>/ >without problems/

 >I'm using it here with 2.6.4, no problems as yet.

 >>/ Something strange happened, I shall try 2.6.4-mm1 shortly to see if 
it /
 >>/ is still the same. I reckon though that I've suffered a filesystem /
 >>/ corruption./

 > A quick thought - have you got CONFIG_REGPARM enabled in the kernel
 > config? If so, disable it and try again. (It's almost certain to
 > cause crashes with binary modules.)
I haven't had CONFIG_REGPARM set in any of the kernels. 2.6.4-rc2-mm1 
was fine until after I first booted 2.6.4-mm1, then neither would work 
with nvidia. I also got some strange stuff happening, including checksum 
errors on the driver and I had to download it again from nvidia.com on 
two occasions, the first redownload reinstalled  once, then  chksum 
errors, the second redownload did the same as well as chksum 
segfaulting, since then it's been fine. See also the garbage I get out 
of vi in an earlier posting.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

