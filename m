Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277560AbRJETYb>; Fri, 5 Oct 2001 15:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277558AbRJETYW>; Fri, 5 Oct 2001 15:24:22 -0400
Received: from cmb1-3.dial-up.arnes.si ([194.249.32.3]:29824 "EHLO
	cmb1-3.dial-up.arnes.si") by vger.kernel.org with ESMTP
	id <S277546AbRJETYJ>; Fri, 5 Oct 2001 15:24:09 -0400
From: Igor Mozetic <igor.mozetic@uni-mb.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15294.2287.812821.556092@cmb1-3.dial-up.arnes.si>
Date: Fri, 5 Oct 2001 21:24:31 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-ac4 (SMP, highmem) complete freeze
In-Reply-To: <15294.1922.204820.340222@cmb1-3.dial-up.arnes.si>
In-Reply-To: <15293.65326.541017.774801@cmb1-3.dial-up.arnes.si>
	<Pine.LNX.4.21.0110051436560.2744-100000@freak.distro.conectiva>
	<15294.1922.204820.340222@cmb1-3.dial-up.arnes.si>
X-Mailer: VM 6.95 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:

 > Can you try to get any backtraces the next time the machine locks up ?
 > 
 > You can use the SysRQ key's for that (documentation about it at
 > Documentation/sysrq.txt). (Alt+SysRQ+T and Alt+SysRQ+P traces)

Well, at the time of this lockup I was in almost on-line contact
with Ingo and we couldn't get anything at all! Screen was dead blank,
no keystroke worked, NumLock didn't work, even Power Off didn't work.
Also, nothing over netconsole. If you have any other suggestion,
please ...

I'm now back to 2.4.3 (which worked reliably for months)
just to make sure that the hardware is OK.
But I strongly suspect kernel, because these deadlock
coincide with 2.4.10 and I don't believe in coincidences.

-Igor Mozetic
