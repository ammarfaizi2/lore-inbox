Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbSIZTPN>; Thu, 26 Sep 2002 15:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSIZTPN>; Thu, 26 Sep 2002 15:15:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:46727 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261449AbSIZTPM>; Thu, 26 Sep 2002 15:15:12 -0400
Date: Thu, 26 Sep 2002 12:21:06 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Michael Clark <michael@metaparadigm.com>,
       "David S. Miller" <davem@redhat.com>, wli@holomorphy.com, axboe@suse.de,
       akpm@digeo.com, linux-kernel@vger.kernel.org, patmans@us.ibm.com,
       andrew.vasquez@qlogic.com
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20020926192106.GD1843@beaverton.ibm.com>
References: <3D92B450.2090805@pobox.com> <20020926.001343.57159108.davem@redhat.com> <3D92B83E.3080405@pobox.com> <20020926.003503.35357667.davem@redhat.com> <3D92C206.2050905@metaparadigm.com> <20020926174148.GB1843@beaverton.ibm.com> <3D934BE7.8010907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D934BE7.8010907@pobox.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik [jgarzik@pobox.com] wrote:
> Has anybody put work into cleaning this driver up?
> 
> The word from kernel hackers that work on it is, they would rather write 
> a new driver than spend weeks cleaning it up :/
> 

Andrew Vasquez from Qlogic can provide more detailed comments on deltas
between the versions of the driver.

The v6.x driver is cleaner and supporting newer kernel interfaces than
past versions.


-andmike
--
Michael Anderson
andmike@us.ibm.com

