Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSAQOKV>; Thu, 17 Jan 2002 09:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288768AbSAQOKM>; Thu, 17 Jan 2002 09:10:12 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:9468 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S288748AbSAQOKA>; Thu, 17 Jan 2002 09:10:00 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020117083757.A7299@thyrsus.com> 
In-Reply-To: <20020117083757.A7299@thyrsus.com>  <20020116204345.A22055@thyrsus.com> <20020116164758.F12306@thyrsus.com> <esr@thyrsus.com> <200201162156.g0GLukCj017833@tigger.cs.uni-dortmund.de> <20020116164758.F12306@thyrsus.com> <26592.1011230762@redhat.com> <20020116204345.A22055@thyrsus.com> <3515.1011257639@redhat.com> 
To: esr@thyrsus.com
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 Jan 2002 14:09:52 +0000
Message-ID: <13681.1011276592@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
>  Please help me correct them.

No. I haven't the time or the inclination to audit the whole of the CML2
rule base to check for such things. Merge a version of CML2 that matches the
CML1 rules as closely as can be expressed in CML2, then submit the
'improvements' later as separate changes - change one thing at a time just
like everyone else does. Then I promise I'll look at the actual behavioural
changes for you as you submit them and Cc them to linux-kernel.

> The definition of "behavioral change" you're implying here is so
> narrow that if I interpreted the "agreement" that way", CML2 could do
> nothing worthwhile. 

Utter crap. CML2 makes them possible, and is a step in the right direction.
I'm not suggesting that you never make these changes - just that you do them
separately from the change in mechanism.

Go read what our Lord and Master said about why he likes Al Viro's patches.
Repeatedly, if needs be.

--
dwmw2


