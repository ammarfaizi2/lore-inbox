Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293552AbSBZJSw>; Tue, 26 Feb 2002 04:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293551AbSBZJSc>; Tue, 26 Feb 2002 04:18:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44300 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293550AbSBZJS3>; Tue, 26 Feb 2002 04:18:29 -0500
Subject: Re: Submissions for 2.4.19-pre [sdmany (Richard Gooch)] [Discuss :) ]
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Tue, 26 Feb 2002 09:29:52 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), me@ohdarn.net (Michael Cohen),
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
In-Reply-To: <200202260324.g1Q3O9I14886@vindaloo.ras.ucalgary.ca> from "Richard Gooch" at Feb 25, 2002 08:24:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fdvk-0008S7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> function so that >128 SD's can be used. You seem to be against this
> patch because it would mean that you can't just keep handing out major
> numbers, ignoring Linus' "no new majors" decree.

Linus no new numbers decree was irrelevant. You can live in your little
ivory tower if it makes you happy, but everyone else works off the post
Linus devices.txt maintained by LANANA.

Even if your hack reflected the newer table it would still be an ugly hack
for a few special case situations rather than any notion of release quality.
Its a very clever devfs hack, but its still an ugly hack

Do it right, and do it in 2.5

Alan
