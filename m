Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbRGYDXM>; Tue, 24 Jul 2001 23:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266516AbRGYDXD>; Tue, 24 Jul 2001 23:23:03 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:48654 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S266514AbRGYDWv>; Tue, 24 Jul 2001 23:22:51 -0400
To: linux-kernel@vger.kernel.org
Cc: kaboom@gatech.edu, chris.ricker@genetics.utah.edu
Subject: Re: 2.4.7 tmpfs strange behaviour
In-Reply-To: <9jl7as$a2h$1@ns1.clouddancer.com>
In-Reply-To: <20010725005940.A5607@werewolf.able.es>    <w53bsm9c06f.wl@megaela.fe.dis.titech.ac.jp>    <20010725025014.A2431@werewolf.able.es> <20010725032634.A1175@werewolf.able.es> <20010725025014.A2431@werewolf.able.es>; from    jamagallon@able.es on Wed, Jul 25, 2001 at 02:50:14 +0200 <9jl7as$a2h$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010725032256.D3F0F785B8@mail.clouddancer.com>
Date: Tue, 24 Jul 2001 20:22:56 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In clouddancer.list.kernel, you wrote:
>
>On 20010725 J . A . Magallon wrote:
>>
>>On 20010725 GOTO Masanori wrote:
>>>> /dev/sdb1              4232960     32840   4200120   1% /mnt/disk
>>>> /root/tmpfs             131072         0    131072   0% /dev/shm
>>>> /tmp/tmpfs              131072         0    131072   0% /dev/shm
>>>> 
>>>> ???? Strange devices.... both mounted under /dev/shm.
>>>
>>>I don't have any problems... mount version is 2.11g on 2.4.7
>>>Uni-Processor and 2.4.7-pre3 SMP.
>>>
>>
>>Mmm, mine is mount-2.11e on 2.4.7 final, SMP box.
>>perhaps mount bug ?
>>Going to get the new one...
>>
>
>Right, mount bug. Version 2.11h works fine...
>
>-- 
>J.A. Magallon                           #  Let the source be with you...        
>mailto:jamagallon@able.es
>Mandrake Linux release 8.1 (Cooker) for i586


This means an update to the Changes documentation.  It lists 2.10o as
the minimum.
