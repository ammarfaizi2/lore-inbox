Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbQLIEEZ>; Fri, 8 Dec 2000 23:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129596AbQLIEEP>; Fri, 8 Dec 2000 23:04:15 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:57868 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129584AbQLIEEG>; Fri, 8 Dec 2000 23:04:06 -0500
Date: Fri, 8 Dec 2000 21:29:29 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: 2.2.18-25 and PS/2 Mouse 
Message-ID: <20001208212929.A10469@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan,

The mouse problems have gone away with the 2.2.18-25 pre-patch.  I 
am not seeing the problems anymore on the affected systems.  I am
trying this evening to apply the 2.4 patch sent to me to see if it
helps with the page cache corruption problem with fork().

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
