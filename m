Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261922AbREMVto>; Sun, 13 May 2001 17:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261928AbREMVte>; Sun, 13 May 2001 17:49:34 -0400
Received: from mail.libertysurf.net ([213.36.80.91]:33574 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S261922AbREMVt3>; Sun, 13 May 2001 17:49:29 -0400
Date: Sun, 13 May 2001 23:49:43 +0200
From: Gab <korsani@hydromail.com>
X-Mailer: The Bat! (v1.51) Personal
Reply-To: Gab <korsani@hydromail.com>
X-Priority: 3 (Normal)
Message-ID: <10317892883.20010513234943@hydromail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: "clock timer configuration lost" error?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting.  This is a KA7 with all power management turned off in the
latest Abit BIOS.

> The kernel puts the timer back and life appears happy again

Ahhh.  The kernel *is* god.


Alan Cox wrote:
> 
> > Feb 26 00:19:52 abit kernel: probable hardware bug: clock timer
> > configuration lost - probably a VIA686a.
> > Feb 26 00:19:52 abit kernel: probable hardware bug: restoring chip
> > configuration.
> > Feb 26 00:26:53 abit xntpd[886]: synchronized to 132.239.254.5,
> > stratum=2
> > ...
> 
> Small number of VIA 686 boxes randomly jump from 100Hz back to the DOS 18Hz
> timeout. We dont know if its hardware or maybe APM bios bugs. The kernel puts
> the timer back and life appears happy again

Well, I have a pentium 66 (o/c @ 100) with a probably very old HP bios,
and I have the problem... and I don't think my Computer have a
VIA686a...
Fun...

-- 

V

Gab


