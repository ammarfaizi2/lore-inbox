Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277432AbRJEQIm>; Fri, 5 Oct 2001 12:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277434AbRJEQIc>; Fri, 5 Oct 2001 12:08:32 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:40137 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S277432AbRJEQIZ>;
	Fri, 5 Oct 2001 12:08:25 -0400
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15293.56077.925419.949405@napali.hpl.hp.com>
Date: Fri, 5 Oct 2001 09:08:45 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, davidm@hpl.hp.com
Subject: Re: ioremap() vs. ioremap_nocache()
In-Reply-To: <E15pXGL-0006n6-00@the-village.bc.nu>
In-Reply-To: <15293.54409.884529.251159@napali.hpl.hp.com>
	<E15pXGL-0006n6-00@the-village.bc.nu>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 5 Oct 2001 16:51:45 +0100 (BST), Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  >> >>>>> On Fri, 5 Oct 2001 12:18:07 +0100 (BST), Alan Cox
  >> <alan@lxorguk.ukuu.org.uk> said:
  >> 
  >> Can you tell me what the answer is to this question?

  >> When is a programmer supposed to use ioremap()
  >> vs. ioremap_nocache().

  Alan> You should never need ioremap_nocache for anything
  Alan> non-ultraweird.

Then who added it and why?

	--david
