Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317945AbSHaTna>; Sat, 31 Aug 2002 15:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317946AbSHaTna>; Sat, 31 Aug 2002 15:43:30 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:57591 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S317945AbSHaTn3>; Sat, 31 Aug 2002 15:43:29 -0400
Message-ID: <3D711CEE.9060309@oracle.com>
Date: Sat, 31 Aug 2002 21:45:50 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Consulting Premium Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Obster <michael.obster@bingo-ev.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19 and binutils 2.13.90.0.3 dont compile
References: <3D710D21.5070101@bingo-ev.de> <3D711BDB.7000906@oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi wrote:
> Michael Obster wrote:
> 
>> Hi,
>>
>> can you have a look on that. Seems for me to be a problem with the new 
>> binutils version, because with binutils 2.12.90.0.4 the kernel 
>> compiles. Is there a workaround present?
> 
> 
> The best thing you can do is to post the actual error you get...

Argh - sorry, I didn't notice the attachment :/

> Anyway, 2.4.20-pre5 is happily built by binutils 2.13.90.0.4
>  and gcc-3.2.

Perhaps gcc-2.95.3 and newest binutils don't get along; have
  you already tried the very latest binutils ?

--alessandro

  "everything dies, baby that's a fact
    but maybe everything that dies someday comes back"
        (Bruce Springsteen, "Atlantic City")

