Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268934AbRHGPwL>; Tue, 7 Aug 2001 11:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268938AbRHGPwA>; Tue, 7 Aug 2001 11:52:00 -0400
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:10763 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S268934AbRHGPvs>; Tue, 7 Aug 2001 11:51:48 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: encrypted swap
In-Reply-To: <5.1.0.14.2.20010807112251.00a8c440@pop.prism.gatech.edu>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 07 Aug 2001 17:51:43 +0200
In-Reply-To: <5.1.0.14.2.20010807112251.00a8c440@pop.prism.gatech.edu> (David Maynor's message of "Tue, 07 Aug 2001 11:28:45 -0400")
Message-ID: <tg4rrjna0g.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Maynor <david.maynor@oit.gatech.edu> writes:

> Then you can use a hardware token so that the machine will not boot at
> all with out it present or write an encrypted super block, but I can't
> really see the advantage of encrypted swap.

This doesn't anything.  Simply connect the hard disk to another
computer.

> At the point it would become effective, the attacker is already on
> the machine (from remote access or the have physical access) and
> then its not if you can keep them from getting the info, its only a
> matter of when.

The machine has got an encrypted file system, of course (perhaps /usr
is not encrypted, but /home certainly is).

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
