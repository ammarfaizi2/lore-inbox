Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUEQOYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUEQOYs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 10:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUEQOYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 10:24:48 -0400
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:55980 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261426AbUEQOYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 10:24:47 -0400
Message-ID: <40A8CB2E.1070108@mrc-bsu.cam.ac.uk>
Date: Mon, 17 May 2004 15:24:46 +0100
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
Organization: MRC Biostatistics Unit
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6 appears to be 3 to 4 times slower than 2.6.5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another "me too" I'm afraid.  I'm running 2.6.6 on an ordinary UP Athlon 
system under Gentoo, and it behaves very strangely.  About 3 out of 4 times, 
it hangs during boot-up, at the "Freeing unused kernel memory" stage, and 
seems to not get as far as calling init....

Yesterday, it got past that stage, and the various startup scripts began to 
run, but *achingly* slowly.  It took about 10 minutes to get most of the 
network services started, with no login prompt in sight - I got fed up and 
rebooted then, because I needed to get some work done!

I rebooted with 2.6.6-rc3, which has always been absolutely fine.

Let me know if any other info would be useful....

Cheers
Alastair

-- 
  \\ ........................................   www.mrc-bsu.cam.ac.uk
   \\  Alastair Stevens, SysAdmin Team       \       01223 330383
   //  MRC Biostatistics Unit, Cambridge UK   \.......................
  --
