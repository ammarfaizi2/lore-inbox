Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263058AbRE1Nji>; Mon, 28 May 2001 09:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263060AbRE1Nj2>; Mon, 28 May 2001 09:39:28 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5906 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263058AbRE1NjP>; Mon, 28 May 2001 09:39:15 -0400
Subject: Re: Linux 2.4.5-ac2
To: fabio@chromium.com (Fabio Riccardi)
Date: Mon, 28 May 2001 14:37:00 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org,
        andrea@suse.de (Andrea Arcangeli), bentw@chello.nl (Ben Twijnstra)
In-Reply-To: <3B11C9AB.72075EC6@chromium.com> from "Fabio Riccardi" at May 27, 2001 08:44:43 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154NCe-000375-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Performance is back to that of 2.4.2-ac26, and stability is a lot better. Under
> heavy FS pressure 2.4.5-ac2 is about 5-10% faster than vanilla 2.4.5, the aa1,2
> kernels have the same performance of vanilla 2.4.5.
> 
> Which one of your changes affected performance so much?

Its much more a case that the 2.4.5 tree got fixed and I picked up the 2.4.5
changes. Its still not perfect (bigmem will deadlock again as in 2.4.5 vanilla
now) but its a much better basis to work from again

