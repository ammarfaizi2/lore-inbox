Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262362AbRERQDd>; Fri, 18 May 2001 12:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262360AbRERQDX>; Fri, 18 May 2001 12:03:23 -0400
Received: from mail.reutershealth.com ([204.243.9.36]:19397 "EHLO
	mail.reutershealth.com") by vger.kernel.org with ESMTP
	id <S262362AbRERQDL>; Fri, 18 May 2001 12:03:11 -0400
Message-ID: <3B05473B.70606@reutershealth.com>
Date: Fri, 18 May 2001 12:00:59 -0400
From: John Cowan <jcowan@reutershealth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; rv:0.9) Gecko/20010505
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@ns.caldera.de>
CC: Jes Sorensen <jes@sunsite.dk>, esr@thyrsus.com,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
In-Reply-To: <20010505192731.A2374@thyrsus.com> <d33da9tjjw.fsf@lxplus015.cern.ch> <20010513112543.A16121@thyrsus.com> <d3d79awdz3.fsf@lxplus015.cern.ch> <20010515173316.A8308@thyrsus.com> <d3wv7eptuz.fsf@lxplus015.cern.ch> <3B054500.2090408@reutershealth.com> <20010518175843.A9347@caldera.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> On Fri, May 18, 2001 at 11:51:28AM -0400, John Cowan wrote:
> 
>>Jes Sorensen wrote:
>>
>>
>>>Telling them to install an updated gcc for kernel compilation
>>>is a necessary evil, which can easily be done without disturbing the
>>>rest of the system. Updating the system's python installation is not a
>>>reasonable request.
>>>
>>
>>Au contraire.  It is very reasonable to have both python and python2
>>installed.  Having two different gcc versions installed is a big pain
>>in the arse.
>>
> 
> Fump. Some distributions do even come with two gcc's out of the box.
> With the whole egcs and gcc2.95 (dunno about 3.0) you can even share
> the compiler driver if you want.


Yes, I should have limited myself to pre-egcs versions.

-- 
There is / one art             || John Cowan <jcowan@reutershealth.com>
no more / no less              || http://www.reutershealth.com
to do / all things             || http://www.ccil.org/~cowan
with art- / lessness           \\ -- Piet Hein

