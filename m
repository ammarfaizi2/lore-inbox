Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129388AbRBGJj7>; Wed, 7 Feb 2001 04:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129380AbRBGJjt>; Wed, 7 Feb 2001 04:39:49 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14098 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129031AbRBGJjn>; Wed, 7 Feb 2001 04:39:43 -0500
Subject: Re: 2.4.x and oops on 'mount -t smbfs'
To: JShaw@jbwere.com.au
Date: Wed, 7 Feb 2001 09:40:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <974A613A43EED311ACBD00508B5EF8C1D66DEF@meexc04.jbwere.com.au> from "JShaw@jbwere.com.au" at Feb 07, 2001 05:19:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14QR5U-0008Em-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any clues or similar experiences???

Known problem. There are some patches that seem to fix it so it should be fixed
in the main 2.4 tree soon
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
