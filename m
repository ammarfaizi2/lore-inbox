Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266321AbRGYAqV>; Tue, 24 Jul 2001 20:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268524AbRGYAqL>; Tue, 24 Jul 2001 20:46:11 -0400
Received: from jalon.able.es ([212.97.163.2]:50613 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S266321AbRGYAqC>;
	Tue, 24 Jul 2001 20:46:02 -0400
Date: Wed, 25 Jul 2001 02:50:14 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: GOTO Masanori <gotom@debian.or.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 tmpfs strange behaviour
Message-ID: <20010725025014.A2431@werewolf.able.es>
In-Reply-To: <20010725005940.A5607@werewolf.able.es> <w53bsm9c06f.wl@megaela.fe.dis.titech.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <w53bsm9c06f.wl@megaela.fe.dis.titech.ac.jp>; from gotom@debian.or.jp on Wed, Jul 25, 2001 at 02:38:48 +0200
X-Mailer: Balsa 1.1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On 20010725 GOTO Masanori wrote:
>> /dev/sdb1              4232960     32840   4200120   1% /mnt/disk
>> /root/tmpfs             131072         0    131072   0% /dev/shm
>> /tmp/tmpfs              131072         0    131072   0% /dev/shm
>> 
>> ???? Strange devices.... both mounted under /dev/shm.
>
>I don't have any problems... mount version is 2.11g on 2.4.7
>Uni-Processor and 2.4.7-pre3 SMP.
>

Mmm, mine is mount-2.11e on 2.4.7 final, SMP box.
perhaps mount bug ?
Going to get the new one...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.7 #1 SMP Mon Jul 23 01:55:36 CEST 2001 i686
