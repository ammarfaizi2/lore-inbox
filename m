Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270585AbRIAMXd>; Sat, 1 Sep 2001 08:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270495AbRIAMXX>; Sat, 1 Sep 2001 08:23:23 -0400
Received: from [145.254.148.183] ([145.254.148.183]:27152 "EHLO
	picklock.adams.family") by vger.kernel.org with ESMTP
	id <S270523AbRIAMXM>; Sat, 1 Sep 2001 08:23:12 -0400
Message-ID: <3B90CE7E.F4F54D9@loewe-komp.de>
Date: Sat, 01 Sep 2001 14:03:10 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Samium Gromoff <_deepfire@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: lilo vs other OS bootloaders was: FreeBSD makes progress
In-Reply-To: <200109011455.f81Ethw00685@vegae.deep.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samium Gromoff wrote:
> 
>  ANdreas Dilger wrote:
> > Win2K even abstracts all SMP/UP code into a module (the HAL) and loads this
> > at boot, thus using the same kernel for both.
>     the only possibility of this shows how ugly is SMP in win2k...
>    this is a situation where they are or geniuses or idiots.
>    MS never proved to be geniuses so they still are idiots...
> 

Did someone any benchmarking?
I expect the loss of performance per application a none issue.
What do you think: >0.5%?
Are you considering interrupt latency in the first place?

Then obviously BeOS is also engineered from idiots...
Oh, and QNX/RTP has separate kernels for UP/SMP. And they
don't need UP/SMP versions of "modules".
