Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269291AbUJWDN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269291AbUJWDN7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269297AbUJWDNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 23:13:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:54662 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269291AbUJWDMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 23:12:12 -0400
Message-ID: <4179CB07.8000405@osdl.org>
Date: Fri, 22 Oct 2004 20:07:51 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
CC: Clemens Schwaighofer <cs@tequila.co.jp>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>	 <41798F74.9090200@tequila.co.jp> <7aaed09104102216131170194b@mail.gmail.com>
In-Reply-To: <7aaed09104102216131170194b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Espen Fjellvær Olsen wrote:
> On 10/23/2004 07:05 AM, Linus Torvalds wrote:
> 
>>Ok,
>> Linux-2.6.10-rc1 is out there for your pleasure.
>>
>>I thought long and hard about the name of this release (*), since one of
>>the main complaints about 2.6.9 was the apparently release naming scheme.
>>
>>Should it be "-rc1"? Or "-pre1" to show it's not really considered release
>>quality yet? Or should I make like a rocket scientist, and count _down_
>>instead of up? Should I make names based on which day of the week the
>>release happened? Questions, questions..
> 
> 
> Do the -rcs first, let them contain everything that should go into the
> next release.
> And when you feel that you have released enough -rcs(Uh, whenever that
> is...) release the -pres.
> They should only contain critical bugfixes before the final release.

Well, several of us think that -pre's should come before the
-rc's and not after them.

It appears that we should concentrate on the
NAME=Zonked Quokka
part of Makefile for our sanity.

-- 
~Randy
