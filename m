Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288612AbSADMLY>; Fri, 4 Jan 2002 07:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288611AbSADMLO>; Fri, 4 Jan 2002 07:11:14 -0500
Received: from [129.27.43.9] ([129.27.43.9]:63247 "EHLO xarch.tu-graz.ac.at")
	by vger.kernel.org with ESMTP id <S288607AbSADMK4>;
	Fri, 4 Jan 2002 07:10:56 -0500
Date: Fri, 4 Jan 2002 13:10:50 +0100 (CET)
From: Alex <mail_ker@xarch.tu-graz.ac.at>
To: linux-kernel@vger.kernel.org
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <3C34D0D9.6010008@free.fr>
Message-ID: <Pine.LNX.4.10.10201041306520.16087-100000@xarch.tu-graz.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Jan 2002, Lionel Bouton wrote:

> MAC configuration is a dream we can't touch.


I just had an idea in case what we might do in case of complex
hardware....

We already have the "command line parameter" that we can provide to the
kernel.

Maybe the best thing would be to supply the kernel a "large" _textfile_
with all the hardware the user definitely has (at such-and such
irq/dma/io); the textfile could be the output resilt from a
"userfriendly" hardware-detection tool that lists all categories of
hardwares etc. and has - generally - a large hardware database. 

What do you think?

Yours, Alex


