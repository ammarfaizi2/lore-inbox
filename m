Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270593AbRHYTOE>; Sat, 25 Aug 2001 15:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270600AbRHYTNz>; Sat, 25 Aug 2001 15:13:55 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30219 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270593AbRHYTNn>; Sat, 25 Aug 2001 15:13:43 -0400
Subject: Re: [resent PATCH] Re: very slow parallel read performance
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Sat, 25 Aug 2001 20:15:44 +0100 (BST)
Cc: riel@conectiva.com.br (Rik van Riel),
        roger.larsson@skelleftea.mail.telia.com (Roger Larsson),
        pcg@goof.com (Marc A. Lehmann), linux-kernel@vger.kernel.org,
        oesi@plan9.de
In-Reply-To: <20010825163648Z16186-32383+1334@humbolt.nl.linux.org> from "Daniel Phillips" at Aug 25, 2001 06:43:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15aiuG-000821-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, lets look into that then.  Surely you hit the wall at some point, no 
> matter which replacement policy you use.  How many simultaneous downloads can 
> you handle with 2.4.7 vs 2.4.8?

How much disk and bandwidth can you afford. With vsftpd its certainly over
1000 parallal downloads on a decent PII box
> 

