Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263655AbVBCPpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbVBCPpZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 10:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbVBCPnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 10:43:45 -0500
Received: from alog0137.analogic.com ([208.224.220.152]:9600 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263142AbVBCPnb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 10:43:31 -0500
Date: Thu, 3 Feb 2005 10:43:26 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: Pankaj Agarwal <pankaj@toughguy.net>, linux-kernel@vger.kernel.org,
       Linux Net <linux-net@vger.kernel.org>
Subject: Re: Query - Regarding strange behaviour.
In-Reply-To: <Pine.LNX.4.53.0502031630290.4228@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.61.0502031042180.9489@chaos.analogic.com>
References: <001501c509ff$d4be02e0$8d00150a@dreammac>
 <Pine.LNX.4.53.0502031630290.4228@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005, Tim Schmielau wrote:

> On Thu, 3 Feb 2005, Pankaj Agarwal wrote:
>
>> In my system there's a strange behaviour.... its not allowing me to create
>> any file in /usr/bin even as root. Its chmod is set to 755. Its even not
>> allowing me to change the chmod value of /usr/bin. The strangest part which
>> i felt is ...its shows the owner and group as root when i issue command
>> "ls -ld /usr/bin" and not allowing root to create any file or directory
>> under /usr/bin and not even allowing to change the chmod value. The error is
>> access permission denied... I can change the chmod value of /usr and other
>> directories under /usr/...but not of bin....
>
> Maybe /usr is mounted read-only?

Hmmm, are distros still 'slicing up' the root file-system?
Good point!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
