Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310580AbSCGWxI>; Thu, 7 Mar 2002 17:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310571AbSCGWw6>; Thu, 7 Mar 2002 17:52:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2310 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310579AbSCGWwr>; Thu, 7 Mar 2002 17:52:47 -0500
Subject: Re: [opensource] Re: Petition Against Official Endorsement of
To: Weimer@CERT.Uni-Stuttgart.DE (Florian Weimer)
Date: Thu, 7 Mar 2002 23:08:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87lmd4ov5b.fsf@CERT.Uni-Stuttgart.DE> from "Florian Weimer" at Mar 07, 2002 11:44:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16j6zb-00045d-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Using BitKeeper might break the way security issues are currently
> handled by distributors of the GNU/Linux system, due to the open
> logging feature.

It simply means security updates have to be kept seperate from the bitkeeper
maintained tree. We can handle that ok. It might mean the first Linus and
Marcelo push into their tree is when the vendor updates go out but thats
not a big problem to arrange
