Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314547AbSDVTWM>; Mon, 22 Apr 2002 15:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314462AbSDVTWL>; Mon, 22 Apr 2002 15:22:11 -0400
Received: from austin.greshamstorage.com ([216.143.252.250]:41999 "EHLO
	austin.openmic.com") by vger.kernel.org with ESMTP
	id <S314548AbSDVTWJ>; Mon, 22 Apr 2002 15:22:09 -0400
Message-ID: <3CC46231.8080008@greshamstorage.com>
Date: Mon, 22 Apr 2002 14:19:13 -0500
From: "Jonathan A. George" <JGeorge@greshamstorage.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020421 Debian/1.rc1-1
MIME-Version: 1.0
To: Jeff Garzik <garzik@havoc.gtf.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <3CC4585F.4060005@greshamstorage.com> <20020422145850.F11216@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>On Mon, Apr 22, 2002 at 01:37:19PM -0500, Jonathan A. George wrote:
>  
>
>>The BK documentation constitutes an implicit advertisement and 
>>endorsement of a product with a license which to many developers 
>>violates the spirit of open source software.
>>
>Agreed.  
>
>And the simple fact of Linus using BitKeeper does the
>_exact_ _same_ _thing_.
>
Not quite.  Linus uses BK as a tool to facilitate kernel development. 
 However, he has not made BK _part_ _of_ _the_ _kernel_. ;-)  Obviously 
anyone can use any tool ON the kernel, but integrating into the kernel 
is something else.

>Talk Linus out of using BitKeeper, and sure, I'll remove the doc.
>
No need.  His tools are his choice.  The kernel itself is ours not his; 
 thus the distinction.

>>This is not to say that BK 
>>is not an effective product, nor that the document in question is useful 
>>for people who choose the tool, but to me it seems comparable to 
>>including a closed source binary module in the kernel distribution. 
>>
>No, it is not comparable at all with that.  There are no license
>problems with the document -- it is GPL'd.
>
The GPL has a specific intent which (though use in the kernel is more 
like the LGPL because binary modules are permitted) which doesn't 
explicitly extend to such documentation.  The spirit of the GPL which 
causes us to exclude binary modules from the distribution very much does 
apply.  To a lawyer this might not matter, but I expect more from a top 
free software contributor like you.

>It describes the same thing as Documentation/SubmittingPatches does, and
>is very relevant to kernel development.
>
In fact I effectively noted its usefulness above.  Thus no argument here.

>>Moving the document to the BK website would be nicer, and would 
>>certainly assauge bad feelings regarding such an integral implicit 
>>endorsement of a tool.
>>
>Removing the doc from the kernel sources would be a token gesture only.
>
I strongly disagree for the reasons I have noted.

>Some developers disagree violently with the use of non-open-source tools
>at all, and that is a fundamental disagreement.
>
>The majority of the "silently seething" developers, I imagine, are only
>gonna be satisfied when (a) BitKeeper is GPL'd or (b) Linus stops using
>BitKeeper.  Both of these seem very remote possibilities at present.
>
Note:  you are not quoting me here ;-)  However, I completely agree.

>	Jeff
>
>P.S.  The doc is _not_ going on the BK website by my hand.  (though I
>have given BitMover permission to post the doc whereever they wish)
>I can maintain my own docs much better than Larry can :)
>
That is a minor detail (as you know).  My suggestion was an attempt to 
balance the value of your admittedly useful document with the nature of 
the endorsement.

--Jonathan--

