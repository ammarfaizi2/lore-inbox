Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264108AbRFFT04>; Wed, 6 Jun 2001 15:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263804AbRFFT0p>; Wed, 6 Jun 2001 15:26:45 -0400
Received: from jalon.able.es ([212.97.163.2]:48846 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S264108AbRFFT0e>;
	Wed, 6 Jun 2001 15:26:34 -0400
Date: Wed, 6 Jun 2001 21:26:27 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David N . Welton" <davidw@apache.org>, linux-kernel@vger.kernel.org
Subject: Re: temperature standard - global config option?
Message-ID: <20010606212627.G1565@werewolf.able.es>
In-Reply-To: <87snhdvln9.fsf@apache.org> <E157ifB-0000I8-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E157ifB-0000I8-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jun 06, 2001 at 21:08:17 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.06 Alan Cox wrote:
> > notice that in some places, Fahrenheit is used, and in some places,
> > Celsius.  It would seem logical to me to have a global config option,
> > so that you *know* that you talk devices either in F or C.
> 
> The spec is farenheit

Kernel is worldwide, should not use anlo-saxon shifted units. Use the
International System of Units (SI)
http://physics.nist.gov/cuu/Units/units.html

Temperature measures in kelvins.

--
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac9 #1 SMP Wed Jun 6 09:57:46 CEST 2001 i686
