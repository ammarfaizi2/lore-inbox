Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278587AbRKVNCb>; Thu, 22 Nov 2001 08:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278592AbRKVNCV>; Thu, 22 Nov 2001 08:02:21 -0500
Received: from [194.228.240.2] ([194.228.240.2]:8723 "EHLO chudak.century.cz")
	by vger.kernel.org with ESMTP id <S278587AbRKVNCK>;
	Thu, 22 Nov 2001 08:02:10 -0500
Message-ID: <3BFCF740.1030009@century.cz>
Date: Thu, 22 Nov 2001 14:01:52 +0100
From: Petr Titera <P.Titera@century.cz>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.6+) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Filesize limit on SMBFS
In-Reply-To: <Pine.LNX.4.30.0111221305520.4258-100000@cola.teststation.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Urban Widmark wrote:

> On Thu, 22 Nov 2001, Petr Tite(ra wrote:
> 
> 
>>    is maximum file size on SMBFS really 2GB? I cannot create file 
>>bigger than that.
>>
> 
> Yes.
> 
> I have patches if you want to be my victim^Wtester.


I'd like to.

> 
> You must be using an NT/2k/XP machine as server, win9x has a 4G limit
> (vfat limit?).


It's NT.

> 
> Let me know which 2.4 kernel you are using. And if you don't already run a
> kernel you compiled yourself, please do that first as you must recompile
> to test the patches anyway (smbfs as a module is recommended, then you
> should be able to only rebuild the modules part).


I use 2.4.15-pre7 (compiled myself :)

> 
> /Urban
> 

Petr

