Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261414AbSIZR6j>; Thu, 26 Sep 2002 13:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261416AbSIZR6j>; Thu, 26 Sep 2002 13:58:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54542 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261414AbSIZR6i>;
	Thu, 26 Sep 2002 13:58:38 -0400
Message-ID: <3D934BE7.8010907@pobox.com>
Date: Thu, 26 Sep 2002 14:03:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Anderson <andmike@us.ibm.com>
CC: Michael Clark <michael@metaparadigm.com>,
       "David S. Miller" <davem@redhat.com>, wli@holomorphy.com, axboe@suse.de,
       akpm@digeo.com, linux-kernel@vger.kernel.org, patman@us.ibm.com
Subject: Re: [PATCH] deadline io scheduler
References: <3D92B450.2090805@pobox.com> <20020926.001343.57159108.davem@redhat.com> <3D92B83E.3080405@pobox.com> <20020926.003503.35357667.davem@redhat.com> <3D92C206.2050905@metaparadigm.com> <20020926174148.GB1843@beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Anderson wrote:
> We have had good results using the Qlogic's driver. We are currently
> running the v6.x version with Failover tunred off on 23xx cards. We have
> run a lot on > 4GB systems also.


Has anybody put work into cleaning this driver up?

The word from kernel hackers that work on it is, they would rather write 
a new driver than spend weeks cleaning it up :/

