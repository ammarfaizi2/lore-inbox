Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVB1P1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVB1P1U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 10:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVB1P1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 10:27:20 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:33667 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261647AbVB1P1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 10:27:03 -0500
Message-ID: <4223393D.3040908@utah-nac.org>
Date: Mon, 28 Feb 2005 08:31:09 -0700
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: Parag Warudkar <kernel-stuff@comcast.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 bug
References: <1109487896.8360.16.camel@localhost> <200502271406.30690.kernel-stuff@comcast.net> <1109545130.7940.2.camel@localhost>
In-Reply-To: <1109545130.7940.2.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I see this problem infrequently on systems that have low memory 
conditions and
with heavy swapping.    I have not seen it on 2.6.9 but I have seen it 
on 2.6.10. 

Jeff

Jean-Marc Valin wrote:

>>Please try stock kernel. 2.6.11-rc3 onwards should be fine. - I saw a similar 
>>problem while running 2.6.10 kernel from Fedora Core 3. It doesn't happen 
>>with stock kernels.
>>    
>>
>
>I did use a stock 2.6.10 kernel (I said custom in the sense that it
>wasn't a Debian kernel). After a reboot, I was able to run fsck on the
>disk (many, many errors) and it went fine after.
>
>	Jean-Marc
>
>  
>

