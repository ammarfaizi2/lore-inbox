Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130077AbRADINK>; Thu, 4 Jan 2001 03:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbRADINA>; Thu, 4 Jan 2001 03:13:00 -0500
Received: from Cantor.suse.de ([194.112.123.193]:55825 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130077AbRADIMv>;
	Thu, 4 Jan 2001 03:12:51 -0500
Date: Thu, 4 Jan 2001 09:12:41 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Pete Zaitcev <zaitcev@metabyte.com>, linux-kernel@vger.kernel.org
Subject: Re: So, what about kwhich on RH6.2?
Message-ID: <20010104091241.B18973@gruyere.muc.suse.de>
In-Reply-To: <3A541361.65942CB3@metabyte.com> <3A5430C6.FBAB094A@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5430C6.FBAB094A@uow.edu.au>; from andrewm@uow.edu.au on Thu, Jan 04, 2001 at 07:13:58PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 07:13:58PM +1100, Andrew Morton wrote:
> Silly question:
> 
> can't we just hardwire `kgcc' into the build system and be done
> with all this kwhich stuff?  It's just a symlink....

And break compilation on all non RedHat 7, non connectiva systems ? 
Would you volunteer to handle the support load on l-k that would cause?


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
