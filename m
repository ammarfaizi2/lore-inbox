Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272143AbRHVWJ7>; Wed, 22 Aug 2001 18:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272142AbRHVWJt>; Wed, 22 Aug 2001 18:09:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2834 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272144AbRHVWJd>; Wed, 22 Aug 2001 18:09:33 -0400
Subject: Re: [problem] RH 2.4.7-2 kernel slows to a crawl under heavy i/o
To: jbusch@half.com (Jeff Busch)
Date: Wed, 22 Aug 2001 23:12:18 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, roswell-list@redhat.com
In-Reply-To: <NEBBJGKHGENBAPAMDILGIEFGGOAA.jbusch@half.com> from "Jeff Busch" at Aug 22, 2001 04:57:35 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZgEU-0002QS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The same setup on RH 6.2 with 2.4.3-ac3 works fine.  Please let me know what
> information may be useful to debugging this problem (no oops yet), and other
> kernels to try; I'm looking at 2.4.8-ac9 right now.

I'd be interested to know how 2.4.8-ac9 fares. It has the saner parts of
the VM work from the Linus tree and other stuff from Rik, Marcelo and co.

Alan
