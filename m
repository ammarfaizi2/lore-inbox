Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264158AbRFFWpD>; Wed, 6 Jun 2001 18:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264220AbRFFWox>; Wed, 6 Jun 2001 18:44:53 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:41889 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S264158AbRFFWoi>;
	Wed, 6 Jun 2001 18:44:38 -0400
Message-Id: <m157m2Q-000OmvC@amadeus.home.nl>
Date: Wed, 6 Jun 2001 23:44:30 +0100 (BST)
From: arjan@fenrus.demon.nl
To: ttsig@tuxyturvy.com (Tom Sightler)
Subject: Re: Linux 2.4.5-ac9
cc: linux-kernel@vger.kernel.org
In-Reply-To: <002e01c0eead$03c6d890$26040a0a@zeusinc.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <002e01c0eead$03c6d890$26040a0a@zeusinc.com> you wrote:
>> 2.4.5-ac9

>> o Fix xircom_cb problems with some cisco kit (Ion Badulescu)

> One other note, the version in 2.4.4-ac11 is listed as 1.33 while the
> version in 2.4.5-ac9 is 1.11, why did we go backwards?  Were there
> significant problems with the newer version?  The 1.33 sure seems to work
> better for me.

It went backwards because I switched from my local CVS repository to the
tulip driver one.

I appologize for the driver not working as well as expected, and will try to
find a way to make it work for everyone .

Greetings,
   Arjan van de Ven
