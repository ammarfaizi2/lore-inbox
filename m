Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312413AbSDEJIH>; Fri, 5 Apr 2002 04:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312414AbSDEJH5>; Fri, 5 Apr 2002 04:07:57 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:39634 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S312413AbSDEJHq>; Fri, 5 Apr 2002 04:07:46 -0500
Date: Fri, 5 Apr 2002 11:07:44 +0200 (CEST)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Oleg Drokin <green@namesys.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Q] reiserfs error message at boot-time
In-Reply-To: <20020405124022.A18140@namesys.com>
Message-ID: <Pine.LNX.4.40.0204051103280.13870-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002, Oleg Drokin wrote:

> Hello!
>
> On Fri, Apr 05, 2002 at 10:37:06AM +0200, Daniel Nofftz wrote:
> > > > i just moved my linux partitition from ext3 to reiserfs.
> > > > now my problem:
> > > > when i boot, i get this error-message:
> > > > reiserfs: Unrecognized mount option errors
> > > > reiserfs: Unrecognized mount option errors
> > > Can you show content of your /etc/fstab?
> > > It complains you passed it unrecognised "errors" option.
> > /dev/hda2       /               reiserfs        defaults,errors=remount-ro
> > 0       1
> > i think it's the "errors=remount-ro" then, or ?
>
> Exactly.
> Get rid of that errors=... option and you'll be fine

thanks ... will test it afap

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

