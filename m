Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289564AbSAONTq>; Tue, 15 Jan 2002 08:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289566AbSAONTf>; Tue, 15 Jan 2002 08:19:35 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:43203 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S289564AbSAONT3>;
	Tue, 15 Jan 2002 08:19:29 -0500
Message-ID: <3C442BDB.7010008@debian.org>
Date: Tue, 15 Jan 2002 14:17:15 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marco Colombo <marco@esi.it>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, esr@thyrsus.com,
        linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery --the elegant solution)
In-Reply-To: <fa.g54h1nv.126slpt@ifi.uio.no> <fa.k72pe6v.1tmgn1a@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2002 13:19:28.0437 (UTC) FILETIME=[42979E50:01C19DC7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marco Colombo wrote:

 
> Alan, Eric (and others, too), please.
> Of course the autoconfigurator is an useful piece of software.
> And of course Eric is posting to the wrong list here. Kernel developers
> don't need any autoconfigurator at all (yes, it's just "extra state").


The main discussion was in kbuild-devel list.

> 
> Eric, Aunt Tillie doesn't need any custom-made, untested, probably not
> working kernel. QA comes at a price. The lastest VM fix may take a while
> to reach mainstream kernels. That's life.

Maybe this force kernel maintainer to merge the tested and trusted
distribution patches into the main kernel's branches.

Anyway, the target of Linux changes. If was a toy for hacker 10 year
ago, maybe in future will be the toy for Aunt Tillies. So:
Forget aunts and the other scenarios of Eric.
Let talk about what autoconfigure can do yet (aka the creation of
a /proc/drivers (better in /dev) with a list of all running
kernel drivers. aka how the modules will be in the next months)

	giacomo

