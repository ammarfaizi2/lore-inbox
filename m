Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271691AbRIKSAf>; Tue, 11 Sep 2001 14:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270464AbRIKSAZ>; Tue, 11 Sep 2001 14:00:25 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:11270 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S270774AbRIKSAR>; Tue, 11 Sep 2001 14:00:17 -0400
Date: 11 Sep 2001 13:29:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <88fBVpFmw-B@khms.westfalen.de>
In-Reply-To: <20010911002956.D582@cadcamlab.org>
Subject: Re: linux-2.4.10-pre5
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20010911002956.D582@cadcamlab.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

peter@cadcamlab.org (Peter Samuelson)  wrote on 11.09.01 in <20010911002956.D582@cadcamlab.org>:

> > I see two possible atime uses:
> >
> > 1. Cleaning up /tmp (mtime is *not* a good indicator that a file is no
> > longer used)
> > 2. Swapping out files to slower storage
> >
> > Essentially, both use the "do we still need this thing" aspect.
>
> The Debian 'popularity-contest' package has an interesting use for
> atime.

Oh yes, forgot about that one. It's still the same idea, though.

>  These go on the first volume of the Debian CD set, to
> make a one-volume Debian CD as useful as possible.

And the others are pushed to the second CD ... "swapping out files to  
slower storage".


MfG Kai
