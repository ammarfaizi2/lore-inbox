Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129659AbQKRPD0>; Sat, 18 Nov 2000 10:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131239AbQKRPDP>; Sat, 18 Nov 2000 10:03:15 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:64936 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129659AbQKRPDJ>; Sat, 18 Nov 2000 10:03:09 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tigran Aivazian <tigran@veritas.com>,
        Mikael Pettersson <mikpe@csd.uu.se>, Jordan <ledzep37@home.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Error in x86 CPU capabilities starting with test5/6
In-Reply-To: <E13wkLK-0000bP-00@the-village.bc.nu> <qwwpujuvk1s.fsf@sap.com>
	<20001117161833.A27098@athlon.random> <qwwaeaytwfa.fsf@sap.com>
	<20001117192834.A30047@athlon.random>
From: Christoph Rohland <cr@sap.com>
Date: 18 Nov 2000 10:57:58 +0100
In-Reply-To: Andrea Arcangeli's message of "Fri, 17 Nov 2000 19:28:34 +0100"
Message-ID: <m33dgpd2l5.fsf@linux.local>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> On Fri, Nov 17, 2000 at 05:06:49PM +0100, Christoph Rohland wrote:
> > Could I get this for i686? :-)
> 
> If we break binary compatibility yes. 

OK, I'll stick to rdtsc on ix86

        Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
