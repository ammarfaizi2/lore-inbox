Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129353AbQKCWEJ>; Fri, 3 Nov 2000 17:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130456AbQKCWEA>; Fri, 3 Nov 2000 17:04:00 -0500
Received: from ganymede.isdn.uiuc.edu ([192.17.19.210]:10000 "EHLO
	ganymede.isdn.uiuc.edu") by vger.kernel.org with ESMTP
	id <S129353AbQKCWDw>; Fri, 3 Nov 2000 17:03:52 -0500
Date: Fri, 3 Nov 2000 16:01:08 -0600
From: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>
To: kuznet@ms2.inr.ac.ru
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
Message-ID: <20001103160108.D16644@ganymede.isdn.uiuc.edu>
In-Reply-To: <20001103202911.A2979@gruyere.muc.suse.de> <200011031937.WAA10753@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200011031937.WAA10753@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Fri, Nov 03, 2000 at 10:37:45PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach kuznet@ms2.inr.ac.ru:
} > de4x5 is probably also buggy in regard to this.
} 
} de4x5 is hopeless. I added nice comment in softnet to it.
} Unfortunately it was lost. 8)
} 
} Andi, neither you nor me nor Alan nor anyone are able to audit
} all this unnevessarily overcomplicated code. It was buggy, is buggy
} and will be buggy. It is inavoidable, as soon as you have hundreds
} of drivers.
} 
If they are buggy and unsupported, why aren't they being expunged from
the main source tree and placed into a ``contrib'' directory or something
for people who may want those drivers?

-- 
|| Bill Wendling			wendling@ganymede.isdn.uiuc.edu
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
