Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129507AbRAEG5N>; Fri, 5 Jan 2001 01:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129610AbRAEG5D>; Fri, 5 Jan 2001 01:57:03 -0500
Received: from sd.skjellin.com ([194.19.28.170]:16402 "HELO sd.skjellin.com")
	by vger.kernel.org with SMTP id <S129507AbRAEG4x>;
	Fri, 5 Jan 2001 01:56:53 -0500
From: "Andre Tomt" <andre@tomt.net>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Change of policy for future 2.2 driver submissions
Date: Fri, 5 Jan 2001 07:57:06 +0100
Message-ID: <OPECLOJPBIHLFIBNOMGBIEGLCHAA.andre@tomt.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <002201c076c7$76cab720$8d19b018@c779218a>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was in your position, I feel it may be a mistake.
> I personaly do not trust the 2.4.x kernel entirely yet, and would
> prefer to
> wait for 2.4.1 or 2.4.2 before upgrading from 2.2.18 to ensure last-minute
> wrinkles have been completely ironed out, and I know there are people who
> share my viewpoint, and would rather use 2.2.XX for a while yet, and I'm
> afraid that this may partialy criple 2.2 driver development.

I would wait for at least 2.4.10 on production systems (servers in
particular). Not to start a flame or anything (yeah, right), but 2.2.x was
not usable on such systems before it reached 2.2.16 IMHO.

So, I guess, the "crippling" of driver submissions could hurt me bit, in
theory, which I don't like. ;-)

--
André. Alfred?
http://www.tomt.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
