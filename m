Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132063AbRALVrw>; Fri, 12 Jan 2001 16:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129957AbRALVrm>; Fri, 12 Jan 2001 16:47:42 -0500
Received: from 150a.pcc.net ([206.135.217.150]:54276 "HELO pcc.net")
	by vger.kernel.org with SMTP id <S132063AbRALVr2>;
	Fri, 12 Jan 2001 16:47:28 -0500
Message-ID: <3A5F7BA7.B2FF852B@pcc.net>
Date: Fri, 12 Jan 2001 15:48:23 -0600
From: Jordan <jordang@pcc.net>
X-Mailer: Mozilla 4.74 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: can't build small enough zImage for floppy
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1st, the Sony Vaio Z505HS appears to be an example of a machine which
will not boot a bzImage correctly, compaining about the compression
format.

2nd, trying to build kernel 2.4.0, I stripped out or module-ized
everything I could (I think) including SCSCI support, the smallest I've
gotten zImage (under 600k) is still too big!

I don't know what else to try.

Thanks for any suggestions.

Jordan



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
