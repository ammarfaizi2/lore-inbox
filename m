Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269693AbRHaW4d>; Fri, 31 Aug 2001 18:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269726AbRHaW4X>; Fri, 31 Aug 2001 18:56:23 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29454 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269693AbRHaW4J>; Fri, 31 Aug 2001 18:56:09 -0400
Subject: Re: [PATCH] usb fix
To: mdharm-kernel@one-eyed-alien.net (Matthew Dharm)
Date: Fri, 31 Aug 2001 23:59:27 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20010831151839.C17480@one-eyed-alien.net> from "Matthew Dharm" at Aug 31, 2001 03:18:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cxG3-0004Bo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That doesn't sound right, Alan...
> 
> The constant in question is an upper-limit to the range of device versions
> what get accepted.  Narrowing the range can only break things -- making it
> wider may not (necessarily) fix anything, but it does increase the scope of
> the entry.
> 

You are indeed correct.  
