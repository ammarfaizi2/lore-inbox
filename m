Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130344AbQKNCDS>; Mon, 13 Nov 2000 21:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130294AbQKNCDI>; Mon, 13 Nov 2000 21:03:08 -0500
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:63241 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S130495AbQKNCCz>; Mon, 13 Nov 2000 21:02:55 -0500
Date: Mon, 13 Nov 2000 18:32:42 -0700
From: Michal Jaegermann <michal@harddata.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org, p_gortmaker@yahoo.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, viro@math.psu.edu
Subject: Re: Linux 2.4 Status/TODO page (test11-pre3)
Message-ID: <20001113183242.A29457@mail.harddata.com>
In-Reply-To: <200011121939.eACJd9D01319@trampoline.thunk.org> <3A0F5B73.E613050B@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5us
In-Reply-To: <3A0F5B73.E613050B@mandrakesoft.com>; from Jeff Garzik on Sun, Nov 12, 2000 at 10:09:39PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2000 at 10:09:39PM -0500, Jeff Garzik wrote:
> tytso@mit.edu wrote:
> > 4. Boot Time Failures
> 
> >      * Various Alpha's don't boot under 2.4.0-test9 (PCI-PCI bridges are
> >        not configured correctly Michal Jaegermann; Richard Henderson may
> >        have an idea what's failing.)
> 
> Move to patch-exists-but-not-merged.  rth has patches, co-developed with
> Ivan Kokshaysky

Would be nice, wouldn't it.  Unfortunately this is not the case.
rth has patches which help to boot his machine, and few others, but
this still does not work in general.

Ivan works now pretty hard, with my involvment into this, trying to
identify and fix the problem.

  Michal
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
