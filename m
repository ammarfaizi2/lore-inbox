Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316836AbSE1QMy>; Tue, 28 May 2002 12:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316837AbSE1QMx>; Tue, 28 May 2002 12:12:53 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:26993 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316836AbSE1QMw>; Tue, 28 May 2002 12:12:52 -0400
Date: Tue, 28 May 2002 12:12:53 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200205281612.g4SGCr821003@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 SRMMU bug revisited
In-Reply-To: <mailman.1022584088.5530.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The BK repository to use has the URL:
>> 
>> 	bk://linux.bkbits.net/linux-2.4
>> 
>> The web stuff is updated still by hand and is as a result chronically
>> out of date.
> 
> Which is a concern since both Linus and Larry made it clear bitkeeper
> would *NEVER* be required of contributors. Is there nothing generating
> nightly tarballs off cron right now ?

It is still not required, in theory. A developer may elect
to wait until the change recycles all the way to Linus,
then receive it with regular kernels. This is what I do --
tired of BK... Also, I am too stupid to understand the
concept of changeset.

-- Pete
