Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261979AbSI1Pm6>; Sat, 28 Sep 2002 11:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262013AbSI1Pm5>; Sat, 28 Sep 2002 11:42:57 -0400
Received: from as2-4-3.an.g.bonet.se ([194.236.34.191]:2432 "EHLO zigo.dhs.org")
	by vger.kernel.org with ESMTP id <S261979AbSI1Pm4>;
	Sat, 28 Sep 2002 11:42:56 -0400
Date: Sat, 28 Sep 2002 17:48:15 +0200 (CEST)
From: =?ISO-8859-1?Q?Dennis_Bj=F6rklund?= <db@zigo.dhs.org>
To: Daniel Egger <degger@fhm.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: detect udma66 cable (vt82c686a)
In-Reply-To: <1033221318.26190.20.camel@sonja.de.interearth.com>
Message-ID: <Pine.LNX.4.44.0209281736430.1349-100000@zigo.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Sep 2002, Daniel Egger wrote:

> > As seen from /proc/ide/via below it thinks my cable is a 40w (on id0 I
> > do have a 40w so that is correct, but in ide1 there is a 80w). The
> > computer is a redhat 7.3 with kernel 2.4.18-4
> 
> Same southbridgem, same kernel, same problem. I sent all sorts of
> messages for this one to Alan but so far there're no news on this
> matter.

I swapped my 80w cable and drive to the primary ide channel and it started
to work. I removed the other drive all together so I don't know what would
happend if I connected that to the second channel.

What I do know is that it is the same cable, same disk with same 
jumper settings as before.

-- 
/Dennis

