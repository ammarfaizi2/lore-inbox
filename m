Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289589AbSBEPdj>; Tue, 5 Feb 2002 10:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289598AbSBEPda>; Tue, 5 Feb 2002 10:33:30 -0500
Received: from ns1.intercarve.net ([216.254.127.221]:20743 "HELO
	ceramicfrog.intercarve.net") by vger.kernel.org with SMTP
	id <S289594AbSBEPdT>; Tue, 5 Feb 2002 10:33:19 -0500
Date: Tue, 5 Feb 2002 10:29:59 -0500 (EST)
From: "Drew P. Vogel" <dvogel@intercarve.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: opening a bzImage?
In-Reply-To: <Pine.LNX.4.30.0202051613010.13539-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0202051029430.20545-100000@northface.intercarve.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you reported the details to the FSF?

--Drew Vogel

On Tue, 5 Feb 2002, Roy Sigurd Karlsbakk wrote:

>They don't even want to give me the source. I keep trying to force them
>the legal way, as they're breaking the GPL
>
>On Tue, 5 Feb 2002, Drew P. Vogel wrote:
>
>> Ahh, just a guess. May I ask why you need to know the contents of the
>> image? The way it sounds is that you are performing a service for the
>> company. If you are, I don't see any reason they would object to giving
>> you the .config.
>>
>> --Drew Vogel
>>
>> On Tue, 5 Feb 2002, Roy Sigurd Karlsbakk wrote:
>>
>> >> I've never tried this, but could you do something like
>> >>
>> >> bunzip2 -c bzImage > zImage && ar -t zImage
>> >
>> >Doesn't work
>> >
>> >bzcat: dist/images/kernel-nfs is not a bzip2 file.
>> >
>> >
>> >--
>> >Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
>> >
>> >Computers are like air conditioners.
>> >They stop working when you open Windows.
>> >
>> >
>>
>>
>>
>
>--
>Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
>
>Computers are like air conditioners.
>They stop working when you open Windows.
>
>



