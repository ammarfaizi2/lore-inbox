Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276612AbRJGTav>; Sun, 7 Oct 2001 15:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276616AbRJGTam>; Sun, 7 Oct 2001 15:30:42 -0400
Received: from cmb1-3.dial-up.arnes.si ([194.249.32.3]:1664 "EHLO
	cmb1-3.dial-up.arnes.si") by vger.kernel.org with ESMTP
	id <S276612AbRJGTa3>; Sun, 7 Oct 2001 15:30:29 -0400
From: Igor Mozetic <igor.mozetic@uni-mb.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15296.44398.38255.552378@cmb1-3.dial-up.arnes.si>
Date: Sun, 7 Oct 2001 21:30:54 +0200
To: george anzinger <george@mvista.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-ac4 (SMP, highmem) complete freeze
In-Reply-To: <3BC09DB5.279ED948@mvista.com>
In-Reply-To: <15293.65326.541017.774801@cmb1-3.dial-up.arnes.si>
	<Pine.LNX.4.21.0110051436560.2744-100000@freak.distro.conectiva>
	<15294.1922.204820.340222@cmb1-3.dial-up.arnes.si>
	<15294.2287.812821.556092@cmb1-3.dial-up.arnes.si>
	<3BC09DB5.279ED948@mvista.com>
X-Mailer: VM 6.95 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger writes:
 >
 > > Well, at the time of this lockup I was in almost on-line contact
 > > with Ingo and we couldn't get anything at all! Screen was dead blank,
 > > no keystroke worked, NumLock didn't work, even Power Off didn't work.
 > > Also, nothing over netconsole. If you have any other suggestion,
 > > please ...
 > 
 > Did you turn on the NMI watchdog?  See
 > .../linux/Documentation/nmi_watchdog.txt in your kernel tree.

Yes.

-Igor
