Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131317AbQKYRC7>; Sat, 25 Nov 2000 12:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129434AbQKYRCt>; Sat, 25 Nov 2000 12:02:49 -0500
Received: from styx.suse.cz ([195.70.145.226]:9208 "EHLO kerberos.suse.cz")
        by vger.kernel.org with ESMTP id <S131317AbQKYRCg>;
        Sat, 25 Nov 2000 12:02:36 -0500
Date: Sat, 25 Nov 2000 17:32:28 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Willy Tarreau <wtarreau@free.fr>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-fbdev@vuser.vu.union.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] G450 support for matroxfb
Message-ID: <20001125173228.A1072@suse.cz>
In-Reply-To: <20001124211333.A29112@vana.vc.cvut.cz> <975166610.3a1fdc928d231@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <975166610.3a1fdc928d231@imp.free.fr>; from wtarreau@free.fr on Sat, Nov 25, 2000 at 04:36:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2000 at 04:36:50PM +0100, Willy Tarreau wrote:
> > BTW, XF4.0.1e is also very unhappy on this hardware.
> > 					Best regards,
> > 						Petr Vandrovec
> > 						vandrove@vc.cvut.cz
> 
> does the Matrox driver work with it ? My G400 works very well with the one I
> found on this site, and the G450 is also referenced :
> 
> http://www.matrox.com/mga/support/drivers/latest/home.htm

Well, XF4.0.1e should work with it if compiled with mgaHALlib.a ...
The Matrox driver referenced above uses this lib.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
