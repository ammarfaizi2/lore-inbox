Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266902AbUBMKPd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 05:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266904AbUBMKPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 05:15:32 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:22223 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266902AbUBMKP0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 05:15:26 -0500
Message-ID: <402CA267.4090202@cyberone.com.au>
Date: Fri, 13 Feb 2004 21:09:43 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Frank <mhf@linuxmail.org>
CC: Andrew Morton <akpm@osdl.org>, Giuliano Pochini <pochini@shiny.it>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
References: <200402130615.10608.mhf@linuxmail.org> <XFMail.20040213095802.pochini@shiny.it> <20040213011012.12645046.akpm@osdl.org> <200402131749.19758.mhf@linuxmail.org>
In-Reply-To: <200402131749.19758.mhf@linuxmail.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Michael Frank wrote:

>On Friday 13 February 2004 17:10, Andrew Morton wrote:
>
>>
>>Yes, 80 cols sucks and the world would be a better place had CodingStyle
>>mandated 96 columns five years ago.  But it didn't happen.
>>
>>
>
>As to "five years ago", what about review the coding style situation before 
>starting 2.7:
>
>In view of better hardware, increasing linelength a little to 96 could be 
>considered without increasing the number of indentation levels.
>
>

I hope not, I usually use 80 columns. Email's using 80 columns.
And lines start becoming difficult for the eyes to follow as they
get longer. Maybe this isn't so much a problem with C code due to
indentation and the sparseness of the lines.

