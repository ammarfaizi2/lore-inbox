Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129118AbQKBRwh>; Thu, 2 Nov 2000 12:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129213AbQKBRw1>; Thu, 2 Nov 2000 12:52:27 -0500
Received: from 134-VALL-X10.libre.retevision.es ([62.83.210.134]:21120 "EHLO
	looping.es") by vger.kernel.org with ESMTP id <S129118AbQKBRwV>;
	Thu, 2 Nov 2000 12:52:21 -0500
Date: Thu, 2 Nov 2000 18:57:06 +0100
From: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
Cc: "CRADOCK, Christopher" <cradockc@oup.co.uk>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Linux-2.4.0-test10
Message-ID: <20001102185706.A984@macula.net>
In-Reply-To: <A528EB7F25A2D111838100A0C9A6E5EF068A1DBC@exc01.oup.co.uk> <3A00B8E9.D5FD12B0@megsinet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.6i
In-Reply-To: <3A00B8E9.D5FD12B0@megsinet.net>; from M.H.VanLeeuwen on Wed, Nov 01, 2000 at 06:44:25PM -0600
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://maculaisdeadsoimmovingit/lightside
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 06:44:25PM -0600, M.H.VanLeeuwen wrote:
> "CRADOCK, Christopher" wrote:
> > I have a similar hardware list and I don't observe any of these problems on
> > 2.4.0-test10x. Is it possibly a hardware conflict somewhere?
> > 
> > What I do see occasionally is if X was ever heavy on the memory usage (say
> > I've run GIMP for a couple of hours) then the text console's font set gets
> > trashed until the next reboot. Console driver failing to reset something?

> Never had the trashed fonts before.

Well, here never did until today :)   With test9, I had left the box idle
downloading stuff over ppp for like 6h under X.  While wget was running,
switched to a vc and with each dot wget printed, the font map got screwed
up more and more.

Not a particular useful report, but I thought I'd mention it in case it
rings a bell somewhere .. UP instead of your SMP, VIA instead of PIIX.
-- 
____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
\ o.O|                                                   2F0D27DE025BE2302C
 =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
   U     chaos and madness await thee at its end."       hkp://keys.pgp.com

Handle via comment channels only.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
