Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262626AbRFLQe0>; Tue, 12 Jun 2001 12:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262633AbRFLQeQ>; Tue, 12 Jun 2001 12:34:16 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37898 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262626AbRFLQeI>; Tue, 12 Jun 2001 12:34:08 -0400
Subject: Re: Clock drift on Transmeta Crusoe
To: pavel@suse.cz (Pavel Machek)
Date: Tue, 12 Jun 2001 17:32:37 +0100 (BST)
Cc: salimma1@yahoo.co.uk (=?iso-8859-1?Q?Mich=E8l_Alexandre_Salim?=),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010611223357.A959@bug.ucw.cz> from "Pavel Machek" at Jun 11, 2001 10:33:57 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E159r5p-0001bp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Mandrake with default kernel 2.4.3, and lastly
> > 2.4.5-ac9), compiled for generic i386 and/or Transmeta
> > Crusoe with APM off or on, one thing sticks out : a
> > clock drift of a few minutes per day.
> Let me guess: vesafb?
> 
> If problem goes away when you stop using framebuffer (i.e. go X), then
> it is known. 

2.4.5-ac has the console irq disaster fixed so I'd expect it to seem ok. 


Alan

