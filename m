Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267516AbSLSA3o>; Wed, 18 Dec 2002 19:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267517AbSLSA3o>; Wed, 18 Dec 2002 19:29:44 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16654 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267516AbSLSA3n>; Wed, 18 Dec 2002 19:29:43 -0500
Date: Thu, 19 Dec 2002 00:37:40 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
Message-ID: <20021219003740.C20566@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200212182237.gBIMbQmk000479@darkstar.example.net> <1040260157.26882.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1040260157.26882.7.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 19, 2002 at 01:09:17AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 01:09:17AM +0000, Alan Cox wrote:
> How the actual patches get applied really isnt relevant. I know Linus
> hated jitterbug, Im guessing he hates bugzilla too ?

I'm waiting for the kernel bugzilla to become useful - currently the
record for me has been:

3 bugs total
3 bugs for serial code for drivers I don't maintain, reassigned to mbligh.

This means I write (choose one):

1. non-buggy code (highly unlikely)
2. code no one tests
3. code people do test but report via other means (eg, email, irc)

If it's (3), which it seems to be, it means that bugzilla is failing to
do its job properly, which is most unfortunate.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

