Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289533AbSBEPLG>; Tue, 5 Feb 2002 10:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289571AbSBEPK4>; Tue, 5 Feb 2002 10:10:56 -0500
Received: from ns1.intercarve.net ([216.254.127.221]:28545 "HELO
	ceramicfrog.intercarve.net") by vger.kernel.org with SMTP
	id <S289533AbSBEPKk>; Tue, 5 Feb 2002 10:10:40 -0500
Date: Tue, 5 Feb 2002 10:07:21 -0500 (EST)
From: "Drew P. Vogel" <dvogel@intercarve.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: opening a bzImage?
In-Reply-To: <Pine.LNX.4.30.0202051605390.13494-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0202051005500.20417-100000@northface.intercarve.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh, just a guess. May I ask why you need to know the contents of the
image? The way it sounds is that you are performing a service for the
company. If you are, I don't see any reason they would object to giving
you the .config.

--Drew Vogel

On Tue, 5 Feb 2002, Roy Sigurd Karlsbakk wrote:

>> I've never tried this, but could you do something like
>>
>> bunzip2 -c bzImage > zImage && ar -t zImage
>
>Doesn't work
>
>bzcat: dist/images/kernel-nfs is not a bzip2 file.
>
>
>--
>Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
>
>Computers are like air conditioners.
>They stop working when you open Windows.
>
>



