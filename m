Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130196AbQLBUfV>; Sat, 2 Dec 2000 15:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130267AbQLBUfM>; Sat, 2 Dec 2000 15:35:12 -0500
Received: from tazenda.demon.co.uk ([158.152.220.239]:10770 "EHLO
	tazenda.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130196AbQLBUe6>; Sat, 2 Dec 2000 15:34:58 -0500
X-Mailer: exmh version 2.1.1 10/15/1999 (debian)
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
cc: Chris Wedgwood <cw@f00f.org>, Donald Becker <becker@scyld.com>,
        Francois Romieu <romieu@cogenit.fr>,
        Russell King <rmk@arm.linux.org.uk>, Ivan Passos <lists@cyclades.com>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC] Configuring synchronous interfaces in Linux 
In-Reply-To: Message from Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com> 
   of "Sat, 02 Dec 2000 13:07:29 CST." <Pine.LNX.3.96.1001202130202.1450B-100000@mandrakesoft.mandrakesoft.com> 
In-Reply-To: <Pine.LNX.3.96.1001202130202.1450B-100000@mandrakesoft.mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 02 Dec 2000 20:02:00 +0000
From: Philip Blundell <philb@gnu.org>
Message-Id: <E142IrA-0007hG-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Does 'ifconfig eth0 media xxx' wind up calling dev->set_config?

Yes.

p.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
