Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267457AbSLLJfN>; Thu, 12 Dec 2002 04:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267460AbSLLJfN>; Thu, 12 Dec 2002 04:35:13 -0500
Received: from elin.scali.no ([62.70.89.10]:32521 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S267457AbSLLJfM>;
	Thu, 12 Dec 2002 04:35:12 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: Terje Eggestad <terje.eggestad@scali.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
In-Reply-To: <3DF78911.5090107@zytor.com>
References: <1039610907.25187.190.camel@pc-16.office.scali.no>
	 <3DF78911.5090107@zytor.com>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1039686176.25186.195.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 12 Dec 2002 10:42:56 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ons, 2002-12-11 at 19:50, H. Peter Anvin wrote:
> Terje Eggestad wrote:
> 
> > 
> > PS:  rdtsc on P4 is also painfully slow!!!
> > 
> 
> Now that's just braindead...
> 

It takes about 11 cycles on athlon, 34 on PII, and a whooping 84 on P4.

For a simple op like that, even 11 is a lot... Really makes you wonder.
 

> 	-hpa

TJ

-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

