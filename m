Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283179AbRLDPc5>; Tue, 4 Dec 2001 10:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283093AbRLDPbX>; Tue, 4 Dec 2001 10:31:23 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:12818 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S283077AbRLDPaa>; Tue, 4 Dec 2001 10:30:30 -0500
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: Over 4-way systems considered harmful :-)
Date: Tue, 4 Dec 2001 07:30:45 -0800
Message-ID: <HBEHIIBBKKNOBLMPKCBBCEOJECAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <9ui5fo$3oe$1@forge.intermeta.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to weigh in here in favor of limiting effort on SMP development by
the core Linux team to systems with 4 processors and under. And not just
because I'd like to see those developers freed up to work on my M-Audio
Delta 66 :-). The economics of massively parallel MIMD machines just aren't
there. Sure, the military guys would *love* to have a petaflop engine, but
they're gonna build 'em anyway and quite probably not bother to contribute
their kernel source on this mailing list. *Commercial* applications for
supercomputers of this level are few and far between. I'm happy with my
GFlop-level UP Athlon Thunderbird. And if Moore's Law (or the AMD equivalent
:-) still holds, in 12 months I'll have something twice as fast (I've had it
for six months already :-).
--
Take Your Trading to the Next Level!
M. Edward Borasky, Meta-Trading Coach

znmeb@borasky-research.net
http://www.meta-trading-coach.com
http://groups.yahoo.com/group/meta-trading-coach

