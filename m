Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVBRCZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVBRCZM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 21:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVBRCZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 21:25:12 -0500
Received: from adsl-69-233-54-133.dsl.pltn13.pacbell.net ([69.233.54.133]:57351
	"EHLO bastard.smallmerchant.com") by vger.kernel.org with ESMTP
	id S261282AbVBRCZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 21:25:05 -0500
Message-ID: <421551F5.5090005@tupshin.com>
Date: Thu, 17 Feb 2005 18:24:53 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McFarland <pmcfarland@downeast.net>
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org, darcs-users@darcs.net
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed
References: <20050214020802.GA3047@bitmover.com> <200502172105.25677.pmcfarland@downeast.net>
In-Reply-To: <200502172105.25677.pmcfarland@downeast.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McFarland wrote:

>On Sunday 13 February 2005 09:08 pm, Larry McVoy wrote:
>  
>
>>Something that unintentionally started a flamewar.
>>    
>>
>
>Well, we just went through another round of 'BK sucks' and 'BK sucks, we need 
>to switch to something else'.
>
>Sans the flamewar, are there any options? CVS and SVN are out because they do 
>not support 'off server' branches (arch and darcs do). Darcs would probably 
>be the best choice because its easy to use, and the darcs team almost has a 
>working linux-kernel import script (originally designed to just test darcs 
>with a huge repo, but provides a mostly working linux tree).
>
>So, without the flamewar, what is everyone's opinion on this? 
>  
>
Speaking as somebody that uses Darcs evey day, my opinion is that the 
future of OSS SCM will be something like arch or darcs but that neither 
are ready for projects the size of the linux kernel yet. Darcs is 
definitely way too slow for really large projects (though great for 
small to medium sized ones). Last I checked, Arch was still too slow in 
some areas, though that might have changed in recent months. Also, many 
people, me included, find the usability of arch to be from ideal.

My hope and expectation is that Arch and Darcs will both improve their 
performance, features, and usability and that in the not too distant 
future both of them will be viable alternatives for large scale source 
tree management.

The important thing for the health of the SCM ecosystem is that there be 
ways to losslessly convert and interoperate between them as well as 
between legacy/centralized systems such as CVS and SVN as well as with BK.

-Tupshin
