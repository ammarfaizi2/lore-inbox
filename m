Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbUCZO3N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 09:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263361AbUCZO3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 09:29:12 -0500
Received: from quechua.inka.de ([193.197.184.2]:32969 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262796AbUCZO3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 09:29:06 -0500
Date: Fri, 26 Mar 2004 15:29:17 +0100
From: Eduard Bloch <edi@gmx.de>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: David Schwartz <davids@webmaster.com>, debian-devel@lists.debian.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
Message-ID: <20040326142917.GB30664@zombie.inka.de>
Mail-Followup-To: Stefan Smietanowski <stesmi@stesmi.com>,
	David Schwartz <davids@webmaster.com>,
	debian-devel@lists.debian.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20040325225423.GT9248@cheney.cx> <MDEHLPKNGKAHNMBLJOLKCEEOLEAA.davids@webmaster.com> <20040326131629.GB26910@zombie.inka.de> <40643BFA.1000302@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40643BFA.1000302@stesmi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Stefan Smietanowski [Fri, Mar 26 2004, 03:19:38PM]:

> >Yes, the driver authors PREFERS to make the changes on the C source
> >code, he never has to modify the firmware. Exactly what the GPL
> >requests, where is your problem?
> 
> But the firmware didn't appear out of thin air - someone wrote it
> somehow. If that's using a hex editor or inside the C code doesn't

The GPL does not talk about the code to create things, but code to
_modify_ things. If you never have to modify the firmware file, where is
the point?

I do not see a big difference between firmware data stored in a flash
rom inside of the hardware part and the same data loaded during the
driver initialisation. In contrary, it saves money and makes things more
flexible. You should thank your hardware manufacturer instead of
bitching about bogus things.

Regards,
Eduard.
-- 
Wenn du einen verhungernden Hund aufliest und machst ihn satt, dann
wird er dich nicht beiﬂen. Das ist der Grundunterschied zwischen Hund
und Mensch.
		-- Mark Twain (eigl. Samuel Langhorne Clemens)
