Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263485AbRFKWLT>; Mon, 11 Jun 2001 18:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264064AbRFKWLJ>; Mon, 11 Jun 2001 18:11:09 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50181 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263997AbRFKWK4>; Mon, 11 Jun 2001 18:10:56 -0400
Subject: Re: BCM5700, 1000 Mbps driver
To: tlan@stud.ntnu.no
Date: Mon, 11 Jun 2001 23:09:39 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010611233530.B10927@flodhest.stud.ntnu.no> from "=?iso-8859-1?Q?Thomas_Lang=E5s?=" at Jun 11, 2001 11:35:30 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E159ZsR-0000Sn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are there any places (besides other drivers in the kernel) to look for
> documents on how to write module-drivers/in-kernel drivers? 

I'd actually suggest

	Documentation/CodingStyle

as a good starting point. Its probably worth making the code clean and easy
to read before trying to do other stuff to it. Its a lot easier to prove
your own changes are correct if you do that after you've proved a reformat and
tidy didnt break it

> Should I start by giving people a link to the source code? ;)  We need this

Sure

