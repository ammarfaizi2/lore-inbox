Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVCOPyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVCOPyy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 10:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVCOPyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 10:54:45 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:7875 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261344AbVCOPyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 10:54:32 -0500
Message-ID: <4237051E.6080107@ca.ibm.com>
Date: Tue, 15 Mar 2005 09:54:06 -0600
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
The 2.6.11.3 kernel with the 2.6.10 driver seems to fail with the same 
sym2 driver error - so I suppose it goes deeper than the driver itself.


O.

