Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129846AbRAZTz3>; Fri, 26 Jan 2001 14:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130119AbRAZTzT>; Fri, 26 Jan 2001 14:55:19 -0500
Received: from mta7.srv.hcvlny.cv.net ([167.206.5.22]:22250 "EHLO mta7")
	by vger.kernel.org with ESMTP id <S129846AbRAZTzI>;
	Fri, 26 Jan 2001 14:55:08 -0500
Date: Fri, 26 Jan 2001 13:15:28 -0500
From: Alan Shutko <ats@acm.org>
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <200101261753.JAA11559@adam.yggdrasil.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, hpa@transmeta.com
Message-id: <87hf2mw56n.fsf@wesley.springies.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.95
In-Reply-To: <200101261753.JAA11559@adam.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> writes:

> 	I am surprised that anyone is seriously considering denying
> service to sites that do not implement an _experimental_ facility
> and have firewalls that try to play things safe by dropping packets
> which have 1's in bit positions that in the RFC "must be zero."

I don't think people are seriously worried whether site implement ECN
right now.

But it would be much nicer to those that _want_ to implement it were
fascist firewalls to set those bits to zero, rather than sending RSTs
back or dripping the packet.  

-- 
Alan Shutko <ats@acm.org> - In a variety of flavors!
Silver's law: If Murphy's law can go wrong it will.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
