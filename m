Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbSJPE3f>; Wed, 16 Oct 2002 00:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264861AbSJPE3f>; Wed, 16 Oct 2002 00:29:35 -0400
Received: from flrtn-5-m1-163.vnnyca.adelphia.net ([24.55.70.163]:43915 "EHLO
	neo.mirai.cx") by vger.kernel.org with ESMTP id <S264853AbSJPE3f>;
	Wed, 16 Oct 2002 00:29:35 -0400
Message-ID: <3DACEC85.3020208@tmsusa.com>
Date: Tue, 15 Oct 2002 21:35:17 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Clark <michael@metaparadigm.com>
CC: GrandMasterLee <masterlee@digitalroadkill.net>,
       Simon Roscic <simon.roscic@chello.at>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
References: <200210152120.13666.simon.roscic@chello.at>	 <1034710299.1654.4.camel@localhost.localdomain>	 <200210152153.08603.simon.roscic@chello.at>	 <3DACD41F.2050405@metaparadigm.com> <1034740592.29313.0.camel@localhost> <3DACEB6E.6050700@metaparadigm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to make sure we are on the same page,
was that LVM1, LVM2, or EVMS?

Joe

Michael Clark wrote:

> I doubt it will make a difference. LVM and qlogic drivers seem
> to be a bad mix. I've already tried the beta5 of 6.01
> and same problem exists - ooops about every 5-8 days.
> Removing LVM and solved the problem.



