Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbTJFIGs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 04:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262836AbTJFIGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 04:06:48 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:13759 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262782AbTJFIGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 04:06:47 -0400
Message-ID: <3F81227C.40900@namesys.com>
Date: Mon, 06 Oct 2003 12:06:20 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Pollard <jesse@cats-chateau.net>
CC: John Lange <john.lange@bighostbox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Valdis.Kletnieks@vt.edu,
       mcmanus@ducksong.com, jmorris@redhat.com
Subject: Re: A new model for ports and kernel security?
References: <Pine.LNX.4.44.0310011523510.14121-100000@thoron.boston.redhat.com> <1065059104.5142.133.camel@mars> <03100208222600.20948@tabby>
In-Reply-To: <03100208222600.20948@tabby>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:

>On Wednesday 01 October 2003 20:45, John Lange wrote:
>  
>
>>A few people suggested various patches which implement a similar
>>functionality to what I was suggesting and I thank them for that.
>>
>>I think this clearly demonstrates that there is a demand for such a
>>feature.
>>    
>>
>
>Not really - that is why they have been external for several years.
>  
>
I would hope that it is more because the grsecurity documentation 
suggests it is still a work in progress.  Perhaps its author might 
consider dividing his work up into smaller patches for Linus to consider.

The original poster was right that restricting ports below 1024 is an 
unclean hack, and a poor substitute for a better permissions model.  
Unfortunately it is an unclean hack in an area where it is difficult for 
society to achieve the decision needed for change.

-- 
Hans


