Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271726AbRHQVdZ>; Fri, 17 Aug 2001 17:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271724AbRHQVdN>; Fri, 17 Aug 2001 17:33:13 -0400
Received: from ool-18b899e0.dyn.optonline.net ([24.184.153.224]:48125 "EHLO
	bouncybouncy") by vger.kernel.org with ESMTP id <S271720AbRHQVdF>;
	Fri, 17 Aug 2001 17:33:05 -0400
Date: Fri, 17 Aug 2001 17:33:18 -0400
From: Justin A <justin@bouncybouncy.net>
To: Jeff Meininger <jeffm@boxybutgood.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'detect' floppy hardware from userland?  ioctl?
Message-ID: <20010817173318.A5313@bouncybouncy.net>
In-Reply-To: <Pine.LNX.4.33.0108171628470.550-100000@mangonel.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108171628470.550-100000@mangonel.localdomain>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

grep fd /proc/devices
:)

-Justin

On Fri, Aug 17, 2001 at 04:31:27PM -0500, Jeff Meininger wrote:
> 
> I'm writing an app that needs to know what floppy drives are connected to
> the system.  Right now, I'm parsing the output of 'dmesg', but 'dmesg' can
> fill up so that the part where floppy drives are listed is no longer
> available.  Is there an ioctl or some other interface for discovering fd0,
> fd1, etc?
> 
> Thanks.
> BTW, I'm not a list member, please Cc: my address!
> -Jeff M
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
