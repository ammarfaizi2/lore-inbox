Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129147AbQKHXjq>; Wed, 8 Nov 2000 18:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129208AbQKHXjg>; Wed, 8 Nov 2000 18:39:36 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:33267 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129147AbQKHXj1>; Wed, 8 Nov 2000 18:39:27 -0500
Date: Wed, 08 Nov 2000 17:39:23 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3A09E161.ACB11253@ihug.co.nz>
Subject: Re: fpu now a must in kernel
X-Mailer: The Polarbar Mailer (pbm 1.17b)
Message-Id: <20001108233934Z129147-31179+2082@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from david <sector2@ihug.co.nz> on Thu, 09 Nov 2000
12:27:29 +1300


> 2 . put the save / restore code in my code (NOT! GOOD! i do not wont to
> do it this way it is not the right way)

That's how most people do it.



-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
