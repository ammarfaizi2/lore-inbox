Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131020AbQKNOsF>; Tue, 14 Nov 2000 09:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130072AbQKNOrz>; Tue, 14 Nov 2000 09:47:55 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:55567 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130414AbQKNOrl>;
	Tue, 14 Nov 2000 09:47:41 -0500
Message-ID: <3A114955.3B58479A@mandrakesoft.com>
Date: Tue, 14 Nov 2000 09:16:53 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel <linux-kernel@i405.com>, linux-kernel@vger.kernel.org
Subject: Re: newbie, 2.4.0-test11-pre4 no compile when CONFIG_AGP=y
In-Reply-To: <1779.974198536@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Tue, 14 Nov 2000 00:56:13 -0800,
> linux-kernel <linux-kernel@i405.com> wrote:
> >I'll preface this saying I'm a kernel compile newbie and I could be making
> >the most basic of mistakes.
> 
> You are.  Hand editing the .config file gives undefined results.  Make
> all changes through menuconfig or xconfig.  The config system does lots
> of work behind the scenes which is not peformed if you hand edit.

Hand editing works just fine...   You just have to remember to run "make
oldconfig" afterwards.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
