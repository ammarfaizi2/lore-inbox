Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130325AbQLIWYZ>; Sat, 9 Dec 2000 17:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130499AbQLIWYP>; Sat, 9 Dec 2000 17:24:15 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:63751 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130325AbQLIWYA>; Sat, 9 Dec 2000 17:24:00 -0500
Date: Sat, 9 Dec 2000 15:49:16 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: 2.2.18-25 DELL Laptop Video Problems
Message-ID: <20001209154916.A14937@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



2.2.18-25 with Frame Buffer enabled will frizt and trash LCD displays
on DELL laptop computers when the system kicks into graphics mode,
and attempts to display the penguin images on the screen.  It 
renders the anaconda installer dead in the water when you attempt 
even a text mode install (not graphics) of a 2.2.18-25 kernel (and 24)
on a DELL laptop.  Is there a way to turn on frame buffer without 
kicking the kernel into mode 274 and killing DELL laptops during
a text based install?

Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
