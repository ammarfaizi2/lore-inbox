Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317148AbSFFU1H>; Thu, 6 Jun 2002 16:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317157AbSFFU1G>; Thu, 6 Jun 2002 16:27:06 -0400
Received: from khms.westfalen.de ([62.153.201.243]:36046 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S317148AbSFFU1F>; Thu, 6 Jun 2002 16:27:05 -0400
Date: 06 Jun 2002 21:31:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8QMRXthXw-B@khms.westfalen.de>
In-Reply-To: <E17Esc6-0000v9-00@starship>
Subject: Re: If you want kbuild 2.5, tell Linus
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

phillips@bonn-fries.net (Daniel Phillips)  wrote on 03.06.02 in <E17Esc6-0000v9-00@starship>:

> Linus has already indicated his position, I guess you were busy writing
> the post so you didn't notice:
>
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=102304528224527&w=2
>
> Plus you've got helpers, how could the situation be better?

I fail to see how this is supposed to work, and I guess so does Keith.

Kai (a different Kai!) does not seem to want to integrate the core part of  
kbuild2.5. He seems to want to only pick the low-hanging fruits and make  
unsupported (and unbelievable) noises about the rest.

And Linus seems to want to ignore the fact that the core portion of  
kbuild2.5 is, by its very nature, not something that can be merged  
"gradually" - just like ALSA, or a new architecture, can't meaningfully be  
merged "gradually". (And he *also* said that he wasn't interested in  
pseudo-gradually, i.e. getting the stuff in parts but still making a big  
exchange.)

Frankly, I see *absolutely no way* how the current Kai-Linus "merge" can  
possibly end with something even remotely like Keith's kbuild2.5. Unless  
Linus changes his approach radically.

If I were Keith, I'd be rather upset, too.

MfG Kai
