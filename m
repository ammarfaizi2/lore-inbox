Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbSKDW5c>; Mon, 4 Nov 2002 17:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262872AbSKDW5c>; Mon, 4 Nov 2002 17:57:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20745 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262871AbSKDW5b>;
	Mon, 4 Nov 2002 17:57:31 -0500
Message-ID: <3DC6FC7C.7080105@pobox.com>
Date: Mon, 04 Nov 2002 18:02:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: Rob Landley <landley@trommello.org>, dcinege@psychosis.com,
       andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge
 candidate list.
References: <200210272017.56147.landley@trommello.org> <20021030085149.GA7919@codepoet.org> <200210300455.21691.dcinege@psychosis.com> <200211011917.16978.landley@trommello.org> <20021104195229.C1407@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:

>Rob Landley wrote:
>  
>
>>Yeah, cpio is a pain and change to use, but so is tar.
>>    
>>
>
>Somebody who strogly dislikes cpio could just write wrapper accepting
>tar-style options. Or add a --cpio option to GNU tar, that switches
>to using the cpio format. One could even try to auto-detect the
>format when reading :-)
>
>- Werner (hates cpio, but not enough)
>  
>


Well, FWIW, "pax" deprecates both cpio and tar.

http://www.opengroup.org/onlinepubs/007904975/utilities/pax.html

In theory pax turns cpio and tar into shell scripts.

    Jeff




