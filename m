Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155153AbQAaOdx>; Mon, 31 Jan 2000 09:33:53 -0500
Received: by vger.rutgers.edu id <S154442AbQAaOB6>; Mon, 31 Jan 2000 09:01:58 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:25575 "EHLO mandrakesoft.mandrakesoft.com") by vger.rutgers.edu with ESMTP id <S155142AbQAaN6d>; Mon, 31 Jan 2000 08:58:33 -0500
Date: Mon, 31 Jan 2000 12:00:00 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Jes Sorensen <Jes.Sorensen@cern.ch>
Cc: linux-kernel@vger.rutgers.edu, mj@ucw.cz
Subject: Re: DMA changes in 2.3.41 - how the f* do I get this working on ARM?
In-Reply-To: <d37lgqquds.fsf@lxplus011.cern.ch>
Message-ID: <Pine.LNX.3.96.1000131115829.23909i-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On 31 Jan 2000, Jes Sorensen wrote:
> Long term merge to a generic device interface sounds good to me. The

FWIW I think we should have a driver_[un]register, not
pci_driver_register, as this interface approaches a sufficiently generic
interface.

	Jeff





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
