Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262298AbSIPUVe>; Mon, 16 Sep 2002 16:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSIPUVe>; Mon, 16 Sep 2002 16:21:34 -0400
Received: from dsl-213-023-040-192.arcor-ip.net ([213.23.40.192]:11146 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262298AbSIPUVd>;
	Mon, 16 Sep 2002 16:21:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Dave Olien <dmo@osdl.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [2.5] DAC960
Date: Mon, 16 Sep 2002 22:26:23 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Samium Gromoff <_deepfire@mail.ru>, linux-kernel@vger.kernel.org
References: <E17odbY-000BHv-00@f1.mail.ru> <20020915131920.GR935@suse.de> <20020916131359.A17880@acpi.pdx.osdl.net>
In-Reply-To: <20020916131359.A17880@acpi.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17r2Rr-0001Vk-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 September 2002 22:13, Dave Olien wrote:
> > 
> > I can only note that so far there has been a lot of talk about dac960
> > and updating it, and that's about it. Talk/code ratio is very very low,
> > I'm tempted to just do the update myself. Might even safe some time.
> > 
> > -- 
> > Jens Axboe
> > 
> > -
> 
> I have the DAC960 driver working in 2.5.34.  The work isn't
> complete yet.  But, I'm able to boot, and do mke2fs
> on partitions on logical drives, and then do e2fsck
> on those partitions.  It seems to work, although more
> testing is required.  Is there any interest in reviewing
> the code so far, or should I continue testing and complete
> the remaining issues first?

Please post the patch, I'll try it right away.

-- 
Daniel
