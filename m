Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289230AbSAVKMH>; Tue, 22 Jan 2002 05:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289229AbSAVKLr>; Tue, 22 Jan 2002 05:11:47 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:21977 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S289224AbSAVKLk>;
	Tue, 22 Jan 2002 05:11:40 -0500
Message-ID: <3C4D3A4A.6020603@debian.org>
Date: Tue, 22 Jan 2002 11:09:14 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: CML2-2.1.3 is available 
In-Reply-To: <fa.d4sn1fv.b78io8@ifi.uio.no> <fa.i3p6mlv.1mg2frl@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jan 2002 10:11:38.0519 (UTC) FILETIME=[2E16DA70:01C1A32D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Keith Owens wrote:

> On Tue, 22 Jan 2002 10:11:10 +0100, 
> Giacomo Catenazzi <cate@debian.org> wrote:
> 
>>If autoconfigure will go in the kernel, I have not problems on
>>filenames, but when I initially created it, I thinked ev. to
>>distribuite it as a package. Here the name matter.
>>
>>IMHO longer filename ia a good things (iff normal user should
>>not type it).
>>
> 
> autoconf autoconfigure: symlinks
>         $(CONFIG_SHELL) scripts/....
> 
> make autoconf == make autoconfigure.
> 
> Watch out for the generated autoconf.h file, it might confuse some
> people.
> 


Where?

I don't find it in:
http://lxr.linux.no/search?v=2.4.17&string=autoconfigure

	giacomo

