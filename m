Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030399AbVIVPSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbVIVPSg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 11:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbVIVPSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 11:18:35 -0400
Received: from eastrmmtao04.cox.net ([68.230.240.35]:19166 "EHLO
	eastrmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030399AbVIVPSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 11:18:35 -0400
Message-ID: <4332CB66.7090107@industrialstrengthsolutions.com>
Date: Thu, 22 Sep 2005 11:19:02 -0400
From: David R <david@industrialstrengthsolutions.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: DMA broken in mainline 2.6.13.2 _AND_ opensuse vendor 2.6.13-15
 - oopsers
References: <433216C2.4020707@industrialstrengthsolutions.com> <1127398965.18840.88.camel@localhost.localdomain>
In-Reply-To: <1127398965.18840.88.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Mer, 2005-09-21 at 22:28 -0400, David R wrote:
>  
>
>>DMA is broken in 2.6.13.2 and opensuse 2.6.13-15, for  my  cdrom/dvd 
>>burner.
>>    
>>
>The trace you posted looks like your .config is totally changed, in
>  
>
>particular that you turned off IDE PCI
>
>
>  
>
You are totaly correct and I apologize for that, the last thing I want 
to do is increase the noise level.  I spent several hours trying to get 
netconsole to work with this, but I spose it just happens to soon. Im 
getting an oops now. (The oops was happening a week or so ago when I 
first tried to upgrade from .12 to .13 by simply using make oldconfig 
and going from there, then I started poking around and eventualy the 
drive worked but with no dma)  Attached is my current oops generating 
config. Here is a digicam shot of my screen:

http://rawdod.com/photo20050922-12:05:56-0007.JPG

Again my drive is a:

LITE-ON DVDRW SOHW-1693S, FwRev=KS09 

And my IDE chip is a:
VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)

Thanks! 

-David

ps. Your beard rocks!




