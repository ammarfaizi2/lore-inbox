Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129465AbRADIIa>; Thu, 4 Jan 2001 03:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbRADIIK>; Thu, 4 Jan 2001 03:08:10 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:24332 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S129465AbRADIH7>; Thu, 4 Jan 2001 03:07:59 -0500
Message-ID: <3A5430C6.FBAB094A@uow.edu.au>
Date: Thu, 04 Jan 2001 19:13:58 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@metabyte.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: So, what about kwhich on RH6.2?
In-Reply-To: <3A541361.65942CB3@metabyte.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Silly question:

can't we just hardwire `kgcc' into the build system and be done
with all this kwhich stuff?  It's just a symlink....

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
