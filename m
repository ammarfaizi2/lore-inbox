Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSESQ3L>; Sun, 19 May 2002 12:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSESQ3K>; Sun, 19 May 2002 12:29:10 -0400
Received: from servidor.unam.mx ([132.248.10.1]:29342 "EHLO servidor.unam.mx")
	by vger.kernel.org with ESMTP id <S314514AbSESQ27>;
	Sun, 19 May 2002 12:28:59 -0400
Subject: Re: Problem with swap partition.
From: David Eduardo Gomez Noguera <davidgn@servidor.unam.mx>
To: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <p04320406b90d7b6ecba5@[192.168.3.11]>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 19 May 2002 11:42:24 -0500
Message-Id: <1021826546.2430.10.camel@hikaru>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-05-19 at 10:56, Christian Jaeger wrote:
> At 11:04 Uhr -0500 19.05.2002, David Eduardo Gomez Noguera wrote:
> >The 3'rd partition is a Linux Swap,
> >/dev/hdc3         77401     77545     73080   82  Linux swap
> 
>           ^^
> 
> >but swapon -a gives
> >swapon: /dev/hdc5: Invalid argument
> 
>                   ^^
> 
> What about correct /etc/fstab entries? :)
> 
> BTW you have done a mkswap on the swap partition, did you?
> 

God, am i stupid.

sorry about the mail.

(i had only make swap partitions once like two years ago, and forgot
about them)

-- 
ICQ: 15605359 Bicho
                                  =^..^=
First, they ignore you. Then they laugh at you. Then they fight you.
Then you win. Mahatma Gandhi.
-------------------------------気検体の一致------------------------------------
暑さ寒さも彼岸まで。
恋にししょうなし。恋はしあんの他。
アン アン アン とっても大好き


