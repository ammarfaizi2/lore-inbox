Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313696AbSDHQq7>; Mon, 8 Apr 2002 12:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313698AbSDHQq6>; Mon, 8 Apr 2002 12:46:58 -0400
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:34981 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S313696AbSDHQq6>; Mon, 8 Apr 2002 12:46:58 -0400
Date: Mon, 8 Apr 2002 17:43:33 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@zip.com.au>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        nahshon@actcom.co.il, Benjamin LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, joeja@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: faster boots?
Message-ID: <20020408174333.A28116@kushida.apsleyroad.org>
In-Reply-To: <200204080048.g380mt514749@lmail.actcom.co.il> <200204080057.g380vbO00868@vindaloo.ras.ucalgary.ca> <3CB0EF0B.14D48619@zip.com.au> <20020408095717.GB27999@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Well, noflushd already seems to work pretty well ;-). But I see kernel
> support may be required for SCSI.

I've had no luck at all with noflushd on my Toshiba Satellite 4070CDT.
It would spin down every few minutes, and then spin up _immediately_,
every time.  I have no idea why.

This was noflushd-2.5-1 (the RPM packaged by Daniel Kobras), on some 2.4
kernel (I don't remember which).  I gave up trying it some months ago.

-- Jamie
