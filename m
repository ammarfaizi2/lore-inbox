Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129174AbRBBNo3>; Fri, 2 Feb 2001 08:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129233AbRBBNoT>; Fri, 2 Feb 2001 08:44:19 -0500
Received: from eschelon.gamesquad.net ([216.115.239.45]:33551 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S129174AbRBBNoJ>; Fri, 2 Feb 2001 08:44:09 -0500
From: "Vibol Hou" <vhou@khmer.cc>
To: <linux-kernel@vger.kernel.org>
Subject: [INFO] 2.2.15 -> 2.4.0/1 Performance
Date: Fri, 2 Feb 2001 05:44:05 -0800
Message-ID: <NDBBKKONDOBLNCIOPCGHCEAPEHAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0011_01C08CDB.276D87F0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0011_01C08CDB.276D87F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

I just thought I'd pass piece of information this to those of you who have
done work on the kernel.  Attached is a PNG image of the CPU usage graph on
one of my most loaded webservers over the past four weeks.  It shows the
HUGE difference in CPU consumption from the now old 2.2+ kernel; you'll
likely be able to tell when I made the change.  Blue lines represent kernel
CPU usage, and green lines represent user CPU usage.  Although I've been
having some issues with the 2.4.0 kernel dying on me after a few days, I'm
going to stay the course on this one and also applaud the hard work and
effort everyone has put into making Linux one of the best operating systems
I've ever used.

Best regards,
Vibol Hou
KhmerConnection, http://khmer.cc
"Connecting Cambodian Minds, Art, and Culture"

------=_NextPart_000_0011_01C08CDB.276D87F0
Content-Type: application/octet-stream;
	name="machine-month[1].png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="machine-month[1].png"

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

------=_NextPart_000_0011_01C08CDB.276D87F0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
