Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129835AbRAVP6P>; Mon, 22 Jan 2001 10:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132394AbRAVP6E>; Mon, 22 Jan 2001 10:58:04 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:53510 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S132216AbRAVP5w>;
	Mon, 22 Jan 2001 10:57:52 -0500
Date: Mon, 22 Jan 2001 16:56:38 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Keith Owens <kaos@ocs.com.au>
Cc: David Luyer <david_luyer@pacific.net.au>, alan@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH: "Pass module parameters" to built-in drivers
Message-ID: <20010122165638.E4979@almesberger.net>
In-Reply-To: <200101210454.f0L4sug02747@typhaon.pacific.net.au> <27169.980053744@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27169.980053744@ocs3.ocs-net>; from kaos@ocs.com.au on Sun, Jan 21, 2001 at 04:09:04PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> Inconsistent methods for setting the same parameter are bad.  I can and
> will do this cleanly in 2.5.

If your approach isn't overly intrusive (i.e. doesn't require changes
to all files containing module parameters, or such), maybe you could
make a patch for 2.4.x and wave it a little under Linus' nose. Maybe
he likes the scent ;-)

In any case, once it's in 2.5.x, and if it is as useful as I suspect
it to be, it would probably be back-ported to 2.4 sooner or later.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
