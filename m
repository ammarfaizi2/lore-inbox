Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314146AbSDVMWJ>; Mon, 22 Apr 2002 08:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314150AbSDVMWI>; Mon, 22 Apr 2002 08:22:08 -0400
Received: from firewall.conet.cz ([213.175.54.250]:3859 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S314146AbSDVMWH>; Mon, 22 Apr 2002 08:22:07 -0400
Message-ID: <3CC3FFC8.8020309@conet.cz>
Date: Mon, 22 Apr 2002 14:19:20 +0200
From: Libor Vanek <lists@conet.cz>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Peter_W=E4chtler?= <pwaechtler@loewe-komp.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Adding snapshot capability to Linux
In-Reply-To: <3CC3ECD2.9000205@conet.cz> <3CC3FCD2.2030008@loewe-komp.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Wächtler wrote:

> Libor Vanìk wrote:
>
>> Hi,
>> I'm going to start my dissertation work which is "Adding snapshop 
>> capability to Linux kernel with copy-on-write support". My idea is 
>> add it as another VFS - I know that there is some snapshot support in 
>> LVM but it's working on "device-level" and I'd like/have to do it on 
>> fs level.
>>
> This functionality already exists in LVM (logical volume manager). 


But AFAIK it doesn't work on fs level but (i.e. you cannot make snapshot 
of some directory which contains NFS/Samba mapped dirs).

Libor



