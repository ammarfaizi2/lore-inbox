Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281323AbRK0P7v>; Tue, 27 Nov 2001 10:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281456AbRK0P7j>; Tue, 27 Nov 2001 10:59:39 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:8967 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S281323AbRK0P71>; Tue, 27 Nov 2001 10:59:27 -0500
Message-ID: <3C03B890.29FDC654@loewe-komp.de>
Date: Tue, 27 Nov 2001 17:00:16 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Martin A. Brooks" <martin@jtrix.com>
CC: ast@domdv.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 'spurious 8259A interrupt: IRQ7'
In-Reply-To: <XFMail.20011127152007.ast@domdv.de> <1576.10.119.8.1.1006871893.squirrel@extranet.jtrix.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin A. Brooks" schrieb:
> 
> > As far as I remember this was talked about earlier. Different mobos,
> > chipsets, processor brands, but always IRQ 7. /me wonders.
> 
> In my research before posting, a common thread seemed to be the presence of
> a tulip card in the machine.  Has anyone seen this on a non-tulip box?
> 

Yes. dmfe.o (Davicom "almost" 2114x)

Athlon with VIA82686_A_. Perhaps it's the Southbridge ?
