Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288664AbSA2GRK>; Tue, 29 Jan 2002 01:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288800AbSA2GQ7>; Tue, 29 Jan 2002 01:16:59 -0500
Received: from marvin.nildram.co.uk ([195.112.4.71]:45828 "HELO
	marvin.nildram.co.uk") by vger.kernel.org with SMTP
	id <S288664AbSA2GQu>; Tue, 29 Jan 2002 01:16:50 -0500
Message-ID: <001f01c1a88c$d6feb8b0$bd7fd0d5@thekhole>
From: "Graeme Read" <graeme@sigma957.net>
To: <dledford@redhat.com>
Cc: <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3C55D031.5040801@redhat.com>
Subject: Re: [PATCH] i810 driver update.
Date: Tue, 29 Jan 2002 06:18:55 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug

> This is the final, cooked version of the i810 driver.  It's been out long
> enough for me to say with a good deal of certainty that it fixes quite a
few
> bugs in the existing driver and doesn't introduce any new bugs (that
doesn't

I've been using this new driver in my kernel (2.4.17 thru 2.4.18-pre6)
without any issues.  It fixed the previous problem I was having with artsd
hanging with a "CPU overload" message during the startup of KDE.

Looks good to me.  Thanks for your work Doug.

Graeme


