Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314483AbSESP4s>; Sun, 19 May 2002 11:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314491AbSESP4r>; Sun, 19 May 2002 11:56:47 -0400
Received: from dclient217-162-171-56.hispeed.ch ([217.162.171.56]:34971 "HELO
	lombi.mine.nu") by vger.kernel.org with SMTP id <S314483AbSESP4r>;
	Sun, 19 May 2002 11:56:47 -0400
Mime-Version: 1.0
Message-Id: <p04320406b90d7b6ecba5@[192.168.3.11]>
In-Reply-To: <1021824299.2430.7.camel@hikaru>
Date: Sun, 19 May 2002 17:56:42 +0200
To: David Eduardo Gomez Noguera <davidgn@servidor.unam.mx>,
        kernel <linux-kernel@vger.kernel.org>
From: Christian Jaeger <christian.jaeger@sl.ethz.ch>
Subject: Re: Problem with swap partition.
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:04 Uhr -0500 19.05.2002, David Eduardo Gomez Noguera wrote:
>The 3'rd partition is a Linux Swap,
>/dev/hdc3         77401     77545     73080   82  Linux swap

          ^^

>but swapon -a gives
>swapon: /dev/hdc5: Invalid argument

                  ^^

What about correct /etc/fstab entries? :)

BTW you have done a mkswap on the swap partition, did you?

Chj.
