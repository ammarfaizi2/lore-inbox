Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130874AbRAZWhl>; Fri, 26 Jan 2001 17:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131096AbRAZWhc>; Fri, 26 Jan 2001 17:37:32 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:29454 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S130874AbRAZWhY>;
	Fri, 26 Jan 2001 17:37:24 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101262237.f0QMbFg320806@saturn.cs.uml.edu>
Subject: Re: RE: hotmail not dealing with ECN
To: lmb@suse.de (Lars Marowsky-Bree)
Date: Fri, 26 Jan 2001 17:37:15 -0500 (EST)
Cc: prandal@herefordshire.gov.uk (Randal Phil),
        linux-kernel@vger.kernel.org ("Linux-Kernel (E-mail)")
In-Reply-To: <20010126173744.A5164@marowsky-bree.de> from "Lars Marowsky-Bree" at Jan 26, 2001 05:37:44 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> We may be right, "they" may be wrong, but in the real world
>> arrogance rarely wins anyone friends.
>
> So you also turn of PMTU and just set the MTU to 200 bytes
> because broken firewalls may drop ICMP ?

Nah, you don't need to go that low. Try 1200 or 1400 instead.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
