Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268347AbUH2W2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268347AbUH2W2i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 18:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268350AbUH2W2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 18:28:38 -0400
Received: from mail5.dslextreme.com ([66.51.199.81]:16817 "HELO
	mail5.dslextreme.com") by vger.kernel.org with SMTP id S268347AbUH2W2f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 18:28:35 -0400
Message-ID: <4132584B.1020903@colannino.org>
Date: Sun, 29 Aug 2004 15:27:23 -0700
From: James Colannino <lkml@colannino.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040821
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: submitting kernel patch for 3w-9*** in 2.4
References: <413217A3.4020906@colannino.org> <20040829182333.GP19844@mea-ext.zmailer.org> <Pine.LNX.4.61.0408291433210.32154@twin.uoregon.edu>
In-Reply-To: <Pine.LNX.4.61.0408291433210.32154@twin.uoregon.edu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Jaeggli wrote:

> On Sun, 29 Aug 2004, Matti Aarnio wrote:
>
>> On Sun, Aug 29, 2004 at 10:51:31AM -0700, James Colannino wrote:
>>
>>> Everyone,
>>>
>>> I've created a kernel patch for 2.4.27 that adds the newer 3w-9xxx 
>>> 3Ware
>>> driver (for the 3Ware 9000 series of controllers).  If anyone here is
>>> interested, I can patch the latest pre-release for 2.4.28 and submit it
>>> to the list.  Just let me know.
>>>
>>> http://james.colannino.org/downloads/patches/3w-9xxx-2.4.27.diff
>>
>>
>> May I suggest you don't use triple-x in its name.
>> Such causes indigestion by several spam filters that people have
>> deployed...  (The aic7xxx as prime example.)
>
>
> got another identifier that would indicate a presence of a variable 
> that won't have some other meaning to a filesystem or user? #### ???? *


Sure.  I just went ahead and named it 3w-9000-2.4.27.diff.  The patch 
can now be found at:

http://james.colannino.org/downloads/patches/3w-9000-2.4.27.diff

James

