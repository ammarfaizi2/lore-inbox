Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129860AbRAQJBg>; Wed, 17 Jan 2001 04:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130339AbRAQJB0>; Wed, 17 Jan 2001 04:01:26 -0500
Received: from cmb1-3.dial-up.arnes.si ([194.249.32.3]:8576 "EHLO
	cmb1-3.dial-up.arnes.si") by vger.kernel.org with ESMTP
	id <S129860AbRAQJA6>; Wed, 17 Jan 2001 04:00:58 -0500
From: Igor Mozetic <igor.mozetic@uni-mb.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14949.24380.105648.57238@cmb1-3.dial-up.arnes.si>
Date: Wed, 17 Jan 2001 10:00:44 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0+aic7xxx doesn't boot, 2.2.17 OK
In-Reply-To: <14948.13544.776999.735127@ravan.camtp.uni-mb.si>
	<3A6479F3.3000305@fugmann.net>
X-Mailer: VM 6.89 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Peter Fugmann writes:

 > Later I saw an announcement from Justin T. Gibbs, who, I beleive, is 
 > currently developing an opensource driver for Adaptec.
 > You can find his patches for the Adaptec aic7xxx driver, for both 2.4.0 
 > and 2.2.8 at: http://people.FreeBSD.org/~gibbs/linux/
 > 
 > The patch makes all problems go away, and all my dics on the Adaptc 
 > controller is now running at full speed. (Great job Gibbs.)

Yes, this solves the problem, thanks.

-Igor Mozetic
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
