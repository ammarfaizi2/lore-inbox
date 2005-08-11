Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVHKPin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVHKPin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVHKPin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:38:43 -0400
Received: from kirby.webscope.com ([204.141.84.57]:28877 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1751097AbVHKPim
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:38:42 -0400
Message-ID: <42FB70EE.6010907@m1k.net>
Date: Thu, 11 Aug 2005 11:38:22 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: cx88 teletext not yet implemented -was- Re: Linux-2.6.13-rc6: aic7xxx
 testers please..
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org> <20050811064217.GB21395@titan.lahn.de> <E1E3CJE-0001NJ-PH@allen.werkleitz.de> <200508111051.01067.gene.heskett@verizon.net>
In-Reply-To: <200508111051.01067.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>I can also report that teletext decoding has ceased to work
>here.  But I'm not sure what kernel version killed it.  Currently
>running 2.6.13-rc6.  But my card is cx88 based, a pcHDTV-3000.  But
>attempting to switch it on/off doesn't seem to generate any output
>indicating it failed, it just Doesn't Work(TM)
>
Gene-

By teletext, I assume you are referring to closed captions.  Are you 
sure that closed captions EVER worked for you on a cx88-based card?  
AFAIK, this feature has not yet been implemented.  I am not at home now, 
so I cannot try it, however, IIRC, closed captions is implemented in 
bttv, and not yet in cx88.

This is a v4l issue, not a dvb issue, however, it is NOT an issue.  This 
is not a regression, because the feature has not yet been implemented.

Gene, if I am wrong, (this is possible) then please provide the last 
kernel version that had this feature correctly implemented.  I don't 
think that I am wrong, though.  Please investigate this and confirm that 
this is an actual regression or not.

Cheers,

-- 
Michael Krufky


