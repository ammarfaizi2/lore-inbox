Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbUCAPiw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 10:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbUCAPiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 10:38:52 -0500
Received: from snota.svorka.net ([194.19.72.11]:31365 "HELO snota.svorka.net")
	by vger.kernel.org with SMTP id S261336AbUCAPiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 10:38:50 -0500
X-Qmail-Scanner-Mail-From: jcb@svorka.no via snota
X-Qmail-Scanner: 1.20 (Clear:RC:1(194.19.72.100):. Processed in 0.013286 secs)
Message-ID: <4043590A.80200@svorka.no>
Date: Mon, 01 Mar 2004 16:38:50 +0100
From: Jo Christian Buvarp <jcb@svorka.no>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Enrico Demarin <enricod@videotron.ca>, linux-kernel@vger.kernel.org
Subject: Re: Ibm Serveraid Problem with 2.4.25
References: <Pine.LNX.4.44.0403011149560.4148-200000@dmt.cyclades>
In-Reply-To: <Pine.LNX.4.44.0403011149560.4148-200000@dmt.cyclades>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wee :) That was it :)
Everything looks fine now :)  Great Work :)

I did the -R against linux-2.4.25 :)

--------------------------------------------------------------
Med vennlig hilsen/Yours sincerely
Jo Christian Buvarp
Svorka Aksess

Notice:
This e-mail may contain confidential and privileged material for the sole use of the intended recipient. Any review or distribution by others is strictly prohibited. If this e-mail is received by others than the intended recipient, please contact the sender and delete all copies.



Marcelo Tosatti wrote:

>On Sun, 29 Feb 2004, Jo Christian Buvarp wrote:
>
>  
>
>>Okay :)
>>I've done some tests now, in the following order:
>>2.4.24-pre3 -> Same problem as before
>>2.4.24-pre2 -> Same problem as before
>>2.4.24-pre1 -> Same problem as before
>>
>>So it looks like the problematic change was added during 2.4.24-pre1
>>
>>To be sure i tested with 2.4.23, and it didn't show anything unusal :)
>>    
>>
>
>Hi fellows,
>
>So it seems the problematic change was added -pre1. Thanks for tracking
>that down Jo!
>
>I suspect the problem is the attached "read last page of file" 
>modification done by Chuck Lever.
>
>Can you guys please apply it with -R to revert and test again?
>
>Thank you so much for your help in this!!! 
>  
>

