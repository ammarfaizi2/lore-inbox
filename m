Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTLAWDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 17:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbTLAWDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 17:03:07 -0500
Received: from [134.29.1.12] ([134.29.1.12]:50576 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S264127AbTLAWDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 17:03:02 -0500
Message-ID: <3FCBBA3F.2090504@mnsu.edu>
Date: Mon, 01 Dec 2003 16:01:35 -0600
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bryan Whitehead <driver@jpl.nasa.gov>
CC: Dan Yocum <yocum@fnal.gov>, Nathan Scott <nathans@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS for 2.4
References: <20031201062052.GA2022@frodo> <3FCBABD9.70309@fnal.gov> <3FCBB790.1030503@jpl.nasa.gov>
In-Reply-To: <3FCBB790.1030503@jpl.nasa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to add my vote also.  I've been using XFS for years.  The XFS 
patches work well.  But having them in the standard kernel would be very 
nice.

-- 
jeffrey hundstad

Bryan Whitehead wrote:

> I'd like to "third" this request. Have a large amount of data here on 
> XFS with v2.4 kernel.
>
> Would be nice to be able to use pre-release 2.4 for testing without 
> having to manually hack in XFS paches from SGI for the odd reject...
>
> Dan Yocum wrote:
>
>> Marcelo,
>>
>> We (Fermilab) second this request.  We won't be touching 2.6 until 
>> it's really stable (read as, Red Hat comes out with an official 
>> distro that has it built in), and we already have *a lot* of XFS 
>> filesystems here (~>300TB) running on 2.4 kernels.  It would be very, 
>> very nice to have it in the 2.4 tree without having to pull it from SGI.
>>
>> Thanks,
>> Dan
>>
>>
>> Nathan Scott wrote:
>>
>>> Hi Marcelo,
>>>
>>> Please do a
>>>
>>>     bk pull http://xfs.org:8090/linux-2.4+coreXFS
>>>
>>> This will merge the core 2.4 kernel changes required for supporting
>>> the XFS filesystem, as listed below.  If this all looks acceptable,
>>> then please also pull the filesystem-specific code (fs/xfs/*)
>>>
>>>     bk pull http://xfs.org:8090/linux-2.4+justXFS
>>>
>>> cheers.
>>>
>>
>
>

