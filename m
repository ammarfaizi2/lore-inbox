Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262675AbVA0R12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbVA0R12 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbVA0RYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:24:52 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:57085 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262681AbVA0RYX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:24:23 -0500
Message-ID: <41F93FE1.7080708@tiscali.de>
Date: Thu, 27 Jan 2005 19:24:17 +0000
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Steve Lord <lord@xfs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Preempt & Xfs Question
References: <41F91470.6040204@tiscali.de> <41F908C4.4080608@xfs.org> <20050127154017.GA12493@taniwha.stupidest.org> <41F9290E.1050209@tiscali.de> <20050127155338.GB12493@taniwha.stupidest.org> <41F931CD.5030401@tiscali.de> <20050127165145.GA13181@taniwha.stupidest.org>
In-Reply-To: <20050127165145.GA13181@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

>On Thu, Jan 27, 2005 at 06:24:13PM +0000, Matthias-Christian Ott wrote:
>
>  
>
>>Well calling such a internal function (__function) is not a cleaning
>>coding style but works best :-) .
>>    
>>
>
>__foo does NOT mean it's an internal function necessarily or that it's
>unclean to use it (sadly Linux has pretty vague (nothing consistent)
>rules on how to interpret __foo versus foo really.
>
>  
>
>>Combined with the current_cpu() fixes I mentioned, it looks like
>>this:
>>    
>>
>
>(1) your patch is mangled/wrapped
>
>(2) this is fixed in CVS already (for maybe a week or so now?)
>
>  
>
>>I'll submit it to the mailinglist as a seperate patch, so Linus can
>>apply it to the current Kernel.
>>    
>>
>
>XFS patches/suggestions should go to linux-xfs@oss.sgi.com and the
>maintainers there can comment as needed.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hi!
I didn't know about the xfs development status. But it's good to hear 
that it's already fixed. When will it be included to the Kernel?

Matthias-Christian Ott

-- 
http://unixforge.org/~matthias-christian-ott/

