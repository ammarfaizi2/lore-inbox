Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVCMUdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVCMUdI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 15:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVCMUdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 15:33:08 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:36517 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261298AbVCMUdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 15:33:05 -0500
Message-ID: <4234A378.1080000@ca.ibm.com>
Date: Sun, 13 Mar 2005 15:32:56 -0500
From: Omkhar Arasaratnam <iamroot@ca.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, tgall@us.ibm.com,
       antonb@au1.ibm.com
Subject: Re: [BUG] 2.6.11- sym53c8xx Broken on pp64
References: <422FA817.4060400@ca.ibm.com>	 <1110420620.32525.145.camel@gaston> <422FBACF.90108@ca.ibm.com>	 <422FC042.40303@ca.ibm.com>	 <Pine.LNX.4.58.0503091944030.2530@ppc970.osdl.org>	 <1110434383.32525.184.camel@gaston>	 <20050310121701.GD21986@parcelfarce.linux.theplanet.co.uk>	 <1110467868.5379.15.camel@mulgrave>  <42307E4D.6080505@ca.ibm.com> <1110492159.32524.261.camel@gaston>
In-Reply-To: <1110492159.32524.261.camel@gaston>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

>On Thu, 2005-03-10 at 11:05 -0600, Omkhar Arasaratnam wrote:
>
>  
>
>>2.6.10 seems to have a different kernel panic which I'm investigating 
>>(could be a problem with my ramdisk as it happens in my linuxrc). So 
>>long story short the 2.6.10 sym driver looks ok.
>>    
>>
>
>Can you try 2.6.11 with the 2.6.10 sym driver ?
>
>Ben.
>
>
>
>  
>
I copied over the code from drivers/scsi/sym53c8xx_2/ on 2.6.10 to the 
2.6.11 dir. The machine didn't come back up after the reboot - I will 
have to wait till Monday to see the error as I do not have remote 
console access to the machine - I will report my findings then.

Omkhar

