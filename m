Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289556AbSBYOmB>; Mon, 25 Feb 2002 09:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289826AbSBYOlv>; Mon, 25 Feb 2002 09:41:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46855 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289556AbSBYOlk>; Mon, 25 Feb 2002 09:41:40 -0500
Message-ID: <3C7A4D1F.9080600@transmeta.com>
Date: Mon, 25 Feb 2002 06:41:35 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Diego Calleja <DiegoCG@teleline.es>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18rc4aa1
In-Reply-To: <20020224165531.A14179@dualathlon.random> <20020224222531.04f44502.DiegoCG@teleline.es> <20020225135052.F3137@inspiron.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> On Sun, Feb 24, 2002 at 10:25:31PM +0100, Diego Calleja wrote:
> 
>>On Sun, 24 Feb 2002 16:55:31 +0100
>>Andrea Arcangeli <andrea@suse.de> wrote:
>>
>>
>>>URL:
>>>
>>>	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18rc4aa1.gz
>>>	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18rc4aa1/
>>>
>>
>>Andrea, I think there's an error on compressed files.
>>-2 times downloaded .gz file(1'3 MB?)= unexpected end of file 
>>-1 time downloaded .bz2 file: Compressed file ends unexpectedly
>>
> 
> I guess one mirror gone wild, CC'ed to Peter just in case he knows. (I
> upload to the staging area, and then an atomic move will make the inode
> visible in /pub, so it shouldn't a problem triggered during the upload
> stage and a wget on the above url worked for me infact)
> 
> (ah, an of course remeber to use binary ftp download :)
> 


Without the IP number of the offending mirror, there is little or no 
hope to track down the problem, if there is one.

	-hpa


