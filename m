Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293212AbSB1Rf7>; Thu, 28 Feb 2002 12:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293525AbSB1Rdq>; Thu, 28 Feb 2002 12:33:46 -0500
Received: from ns.suse.de ([213.95.15.193]:28426 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293632AbSB1Rbx>;
	Thu, 28 Feb 2002 12:31:53 -0500
Date: Thu, 28 Feb 2002 18:31:20 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Teodor.Iacob@astral.kappa.ro
Cc: Chris Rankin <cj.rankin@ntlworld.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.18 : lots of "state D" processes
Message-ID: <20020228183120.C1705@inspiron.school.suse.de>
In-Reply-To: <200202272307.g1RN7jsg000527@twopit.underworld> <Pine.LNX.4.31.0202281236420.8068-100000@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0202281236420.8068-100000@linux.kappa.ro>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2002 at 12:38:13PM +0200, Teodor Iacob wrote:
> Hello,
> 
> I got a few stats "D" process also with 2.4.19-pre1-rmap12g, the processes
> were using my usb printer, which actually I never got it to work anyway
> because this was the first kernel to try to make it work, and ofc I
> couldn't kill the processes, but the reboot went cleanly.

Can you reproduce on 2.4.19pre1aa1?

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre1aa1.bz2

Andrea
