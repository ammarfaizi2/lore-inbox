Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVBCNC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVBCNC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 08:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbVBCNC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 08:02:28 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:17171 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S263414AbVBCNCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 08:02:15 -0500
Message-ID: <4202214C.6090907@hist.no>
Date: Thu, 03 Feb 2005 14:04:12 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux@horizon.com
CC: frnk_kln@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: Copyright / licensing question
References: <20050203120454.5815.qmail@science.horizon.com>
In-Reply-To: <20050203120454.5815.qmail@science.horizon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:

>I'll respond in terms of U.S. law; if you want something else, please
>mention it.
>
>You might find a lot of useful information at
>http://fairuse.stanford.edu/Copyright_and_Fair_Use_Overview/chapter9/index.html
>http://www.usg.edu/admin/legal/copyright/#part3d3a
>http://en.wikipedia.org/wiki/Fair_use
>ttp://www.nolo.com/lawcenter/ency/article.cfm/ObjectID/C3E49F67-1AA3-4293-9312FE5C119B5806/catID/2EB060FE-5A4B-4D81-883B0E540CC4CB1E
>
>  
>
>>1. For explaining the internals of a filesystem in detail, I need to
>>   take their code from kernel sources 'as it is' in the book. Do I need
>>   to take any permissions from the owner/maintainer regarding this ?
>>   Will it violate any license if reproduce the driver source code in
>>   my book ??
>>    
>>
>
>This is exactly the sort of "Comment and criticism" that is anticipated
>and covered by the fair use exemption.  In judging whether the use is
>fair, 17 USC 107 says:
>  
>
Nice analysis, but is it necessary in this case?
GPL is somewhat special, in that it allows unlimited distribution of
unmodified and modified code, as long as:
1. The copyright notice remains - trivial to do in a book by keeping the
    copyright notices.  A book tend to have a copyright notice of its own,
    where he may mention the different licence/copyright for the code parts.
2. He offer the sources to anyone interested - again trivial because the
    book actually distributes the source in written form.  So he won't 
need to
    set up a ftp server the way binary vendors usually have to.

So I believe he'll be fine as long as he makes it clear that the source 
code listings
have a different copyright from the rest of the book - i.e. people can 
copy and use that
code in all the ways the GPL permits.

"Fair use" and such is nice to have, but one doesn't need to invoke it 
when the
source code in question already offer a unlimited redistribution 
licence.  Printing the
code in some book is just redistribution, after all.  He have to make 
sure he prints the GPL
along with the code, that's about it.

Helge Hafting


