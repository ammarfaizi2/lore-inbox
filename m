Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285262AbRLMXd7>; Thu, 13 Dec 2001 18:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285261AbRLMXdt>; Thu, 13 Dec 2001 18:33:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23561 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S285259AbRLMXdl>;
	Thu, 13 Dec 2001 18:33:41 -0500
Message-ID: <3C193AD3.55AFF698@mandrakesoft.com>
Date: Thu, 13 Dec 2001 18:33:39 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Johan Kullstam <kullstam@ne.mediaone.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre11 de2104X tulip driver problem
In-Reply-To: <20011213150346.A31843@Sophia.soo.com> <m2hequpw3a.fsf@euler.axel.nom>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Kullstam wrote:
> i have a DEC DE450 (based on 21041 AA chipset).  i guess, for
> 2104[01], tulip driver has been broken since 2.4.4 (yes, that's over
> six months of brokeness).  yes, jeff garzik knows about it.  i've
> emailed the list and sourceforge &c.

This is a bug report for de2104x not tulip.  de2104x was created to fix
the 2104x problems in tulip, which is getting really hairy to maintain.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
