Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271103AbTHHK1e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 06:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271116AbTHHK1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 06:27:34 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:54124 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S271103AbTHHK1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 06:27:33 -0400
Message-ID: <3F337B14.2000307@sbcglobal.net>
Date: Fri, 08 Aug 2003 05:27:32 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA problem with 2.6.0-test1
References: <Pine.SOL.4.30.0308072019250.3600-100000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0308072019250.3600-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know, I've had a few SMART capable Maxtor drives go bad to the 
point I knew it without a warning.  Eventually, when things got really 
bad though, they would report SMART errors.  The errors were at first 
intermittent, and then got to the point the warning wouldn't go away.  
In their defense, two of them (I've had 5) had smart errors and I never 
encountered any noticeable defects (still, I replaced them when they 
were doing the upgrade program so I could get a new 3 year warranty). 

All of those are several generations old though, the newer ones I have 
now don't seem to want to die ;-)

--Wes--

Bartlomiej Zolnierkiewicz wrote:

>Can be buggy drive's firmware or bug in smartmontools (unlikely)...
>
>--bartlomiej
>
>On Thu, 7 Aug 2003, Mike Castle wrote:
>
>  
>
>>In article <Pine.SOL.4.30.0308061750260.22000-100000@mion.elka.pw.edu.pl>,
>>Bartlomiej Zolnierkiewicz  <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
>>    
>>
>>>You can also install smartmontools (http://smartmontools.sf.net/)
>>>and check your drives (if they support SMART of course).
>>>      
>>>
>>Point of interest:  I just had a Maxtor drive go bad on me recently.  Their
>>diag tools caught it, as did my ear (made a nice clunking noise :-).  But
>>SMART didn't report a thing, and I looked hard too.  :-/
>>
>>mrc
>>    
>>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

