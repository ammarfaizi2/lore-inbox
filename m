Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317585AbSFMLD4>; Thu, 13 Jun 2002 07:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317588AbSFMLDz>; Thu, 13 Jun 2002 07:03:55 -0400
Received: from [195.63.194.11] ([195.63.194.11]:48902 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317585AbSFMLDy> convert rfc822-to-8bit; Thu, 13 Jun 2002 07:03:54 -0400
Message-ID: <3D087C18.6010406@evision-ventures.com>
Date: Thu, 13 Jun 2002 13:03:52 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Gabor Kerenyi <wom@tateyama.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: driver documentation
In-Reply-To: <200206131954.41348.wom@tateyama.hu>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Gabor Kerenyi napisa³:
> Hi!
> 
> I have written a driver for a PCI card (produced by the company I work
> for) and it's working well. Now I should write a documentation, but
> I have never done such kind of low level tasks in a PC enviroment.
> I know what design docs and other docs are needed for a normal
> program (C, C++) but I have no idea how I could write a doc
> for a driver.
> 
> Is there any template there? I bet you also had to write documentations
> if you work for a company.
> 
> Can anybody give some advice? Of course I would like to write it
> using Linux, so please don't mention M$ only sws! (bad news that
> my boss would like to view it on M$ :(((( )
> 
> (ps. I don't like flowcharts...)

Since I assume that the request is about documenting the
internals of the driver, I recommend that you look at
the javadoc similar embedded documentation mechanism found in
recent linux kernels. Just type in make doc on the top level
and see. Well if you are looking at what to put in there:
Just please look after the corresponding comments throughout
the kernel.


