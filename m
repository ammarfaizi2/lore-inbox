Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280938AbRKHA4p>; Wed, 7 Nov 2001 19:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280918AbRKHA4e>; Wed, 7 Nov 2001 19:56:34 -0500
Received: from james.kalifornia.com ([208.179.59.2]:31024 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S280807AbRKHA4Z>; Wed, 7 Nov 2001 19:56:25 -0500
Message-ID: <3BE9D7BD.7030308@blue-labs.org>
Date: Wed, 07 Nov 2001 19:54:21 -0500
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011101
X-Accept-Language: en-us
MIME-Version: 1.0
To: antirez <antirez@invece.org>
CC: "Brenneke, Matthew Jeffrey (UMR-Student)" <mbrennek@umr.edu>,
        "'H. Peter Anvin'" <hpa@zytor.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Yet another design for /proc. Or actually /kernel.
In-Reply-To: <6CAC36C3427CEB45A4A6DF0FBDABA56D59C91D@umr-mail03.cc.umr.edu> <20011108012051.C568@blu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That doesn't solve anything if the data value includes ( or ).  It just 
avoids ' ' in the data value and adds complexity.

-d

antirez wrote:

>((dev/hda1)(/home/mbrennek/stuff and)(vfat)(rw)(0)(0))
>((/dev/hda2)(/var/tmp)(ext2)(rw)(0)(0))
>

