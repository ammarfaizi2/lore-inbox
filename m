Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLNQqR>; Thu, 14 Dec 2000 11:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129423AbQLNQqG>; Thu, 14 Dec 2000 11:46:06 -0500
Received: from ulisse.provincia.parma.it ([195.120.125.15]:34503 "EHLO
	ulisse.provincia.parma.it") by vger.kernel.org with ESMTP
	id <S129267AbQLNQp5>; Thu, 14 Dec 2000 11:45:57 -0500
Message-ID: <3A38F21E.B135B1C8@ca.provincia.parma.it>
Date: Thu, 14 Dec 2000 16:15:26 +0000
From: Marco Nardelli <marco@ca.provincia.parma.it>
Reply-To: marco@ca.provincia.parma.it
X-Mailer: Mozilla 4.5 [en] (X11; U; Linux 2.2.12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: macro MSG_PEEK
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,
I have some trouble in testing a Perl module.
The "make test" gives me this problem:

t/07io..............Your vendor has not defined Socket macro MSG_PEEK,
used at blib/lib/Convert/BER.pm line 968
dubious

and I didn't find this macro defined in "sys/types.h" or in
"sys/socket.h" or in any other header.
Can anyone help me?
Does anyone know where I can find the macro MSG_PEEK?
thanks in advance
marco nardelli

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
