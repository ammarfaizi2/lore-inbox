Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRCABhw>; Wed, 28 Feb 2001 20:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRCABhk>; Wed, 28 Feb 2001 20:37:40 -0500
Received: from zeus.kernel.org ([209.10.41.242]:51676 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129417AbRCAB2Y>;
	Wed, 28 Feb 2001 20:28:24 -0500
Date: Wed, 28 Feb 2001 17:04:12 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <morton@nortelnetworks.com>, ebuddington@wesleyan.edu,
        linux-kernel@vger.kernel.org
Subject: Re: time drift and fb comsole activity
Message-ID: <20010228170412.N28471@ftsoj.fsmlabs.com>
In-Reply-To: <20010228165942.M28471@ftsoj.fsmlabs.com> <E14YGZj-0006nh-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E14YGZj-0006nh-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Mar 01, 2001 at 12:04:04AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

} > } The fbdev console problem is too horrible to pretend to solve by resyncing
} > } on timer interrupts. At least for the x86 the fix is to sort out the fb
} > } locking properly
} > 
} > How close is that?
} 
} Its not in itself a big problem, but since it doesnt reformat your hard disk,
} explode randomly or drop you off the network its not at the top of my priority
} list right now

I'll stick with the pretend fix that results in accurate time-keeping,
then.

Thanks for the info.
