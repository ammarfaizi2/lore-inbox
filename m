Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130939AbRBXAf0>; Fri, 23 Feb 2001 19:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130955AbRBXAfL>; Fri, 23 Feb 2001 19:35:11 -0500
Received: from abyss.devicen.de ([194.25.37.241]:30217 "EHLO abyss.devicen.de")
	by vger.kernel.org with ESMTP id <S130939AbRBXAeq>;
	Fri, 23 Feb 2001 19:34:46 -0500
Date: Sat, 24 Feb 2001 01:34:51 +0100
From: Oliver Teuber <teuber@abyss.devicen.de>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org, J.A.K.Mouw@ITS.TUDelft.NL
Subject: Re: reiserfs: still problems with tail conversion
Message-ID: <20010224013451.A6833@abyss.devicen.de>
In-Reply-To: <20010223221856.A24959@arthur.ubicom.tudelft.nl> <730960000.982966246@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <730960000.982966246@tiny>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2001 at 05:10:46PM -0500, Chris Mason wrote:
> On Friday, February 23, 2001 10:18:56 PM +0100 Erik Mouw
> <J.A.K.Mouw@ITS.TUDelft.NL> wrote:
> > I am running linux-2.4.2-pre4 with Chris Mason's tailconversion bug fix
> > applied, but I still have problems with null bytes in files. I wrote a
> > little test program that clearly shows the problem:
> Many thanks for sending along a test program for reproducing.  But, it
> doesn't seem to reproduce the problem here, how many times did you have to
> run it to see the null bytes?  Do you remove the files between runs?

i cant reproduce the problem on my system runnig 2.4.2, too.

no problem so far ;)

reiserfs on an 46gb ibm ide hdd, 750mhz p3, 256mb ram

yours, oliver teuber

