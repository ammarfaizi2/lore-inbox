Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261637AbREOWMi>; Tue, 15 May 2001 18:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbREOWM2>; Tue, 15 May 2001 18:12:28 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13829 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261637AbREOWMP>; Tue, 15 May 2001 18:12:15 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: jsimmons@transvirtual.com (James Simmons)
Date: Tue, 15 May 2001 23:07:40 +0100 (BST)
Cc: nico@cam.org (Nicolas Pitre), hpa@transmeta.com (H. Peter Anvin),
        torvalds@transmeta.com (Linus Torvalds),
        viro@math.psu.edu (Alexander Viro),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        neilb@cse.unsw.edu.au (Neil Brown),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.10.10105151424161.22038-100000@www.transvirtual.com> from "James Simmons" at May 15, 2001 02:28:11 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zmyi-0003Be-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I couldn't agree with you more. It gives me headaches at work. One note,
> their is a except to the eth0 thing. USB to USB networking. It uses usb0,
> etc. I personally which they use eth0.  
> 

The packet framing is quite different so it doesnt really make sense. For
wireless it does use ethernet packet format so it makes sense

