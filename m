Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289918AbSAOPDy>; Tue, 15 Jan 2002 10:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289908AbSAOPDp>; Tue, 15 Jan 2002 10:03:45 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:31497 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S289882AbSAOPDf>;
	Tue, 15 Jan 2002 10:03:35 -0500
Message-ID: <3C444441.3080608@debian.org>
Date: Tue, 15 Jan 2002 16:01:21 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marco Colombo <marco@esi.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery --the elegant solution)
In-Reply-To: <Pine.LNX.4.33.0201151517550.11441-100000@Megathlon.ESI>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2002 15:03:33.0707 (UTC) FILETIME=[CD1031B0:01C19DD5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marco Colombo wrote:

>>
>>The main discussion was in kbuild-devel list.
>>
> 
> Uh, my mailbox hurts just at the thought of even more posting on the suject.
> 


In kbuild: less people, less traffic, more discussion, less flames

> Kernel tarballs are for hackers. Marcelo can't test any configuration
> the autoconfigurator can produce. So basically it means an untested
> kernel. Running untested kernel isn't a job for Joe User, and never
> will be.


Also what are the stable series?

But you think your distribution test the kernel in all possible
use? With all possible hardware configuration?
Autoconfiguration will configure a compile and booting kernel.
(but on old machine). Neither vendor can assure you that the kernel
will work for a particolar permutation of hardware, and mainly
it is indipendent from configuration.


> Vendors and kernel developers have different goals. That horrible hack
> that fixes some bug or misbehavior fits fine into a vendor kernel, and
> has no place in Marcelo's tree; the same for that C++ written, cross OS
> crap driver for hardware XYZ. Users want it, vendors provide it.
> Different goals, different targets.


Change distribution. In Debian/unstable developers and distribution are
hardly linked!
Why do you need someone in the 'layer' between developers
and user?


> Autoconfiguration is nice. But please move the topic elsewhere.


Right. Let stop it


	giacomo

