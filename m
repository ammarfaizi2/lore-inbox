Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131667AbQKNXVp>; Tue, 14 Nov 2000 18:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbQKNXVf>; Tue, 14 Nov 2000 18:21:35 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:24049 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S131667AbQKNXVY>; Tue, 14 Nov 2000 18:21:24 -0500
Date: Tue, 14 Nov 2000 16:51:20 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20001114163154.A3328@hapablap.dyn.dhs.org>
In-Reply-To: <20001114222843Z131509-521+212@vger.kernel.org> <20001114222843Z131509-521+212@vger.kernel.org>; from ttabi@interactivesi.com on Tue, Nov 14, 2000 at 03:58:38PM -0600
Subject: Re: "couldn't find the kernel version the module was compiled for" - help!
X-Mailer: The Polarbar Mailer (pbm 1.17b)
Message-Id: <20001114232133Z131667-522+140@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Steven Walter <srwalter@hapablap.dyn.dhs.org> on Tue,
14 Nov 2000 16:31:54 -0600


> If my understanding is correct, you need to include version.h without
> "#define __NO_VERSION__" in one and only one of your module's .c files.
> More than one, and you get redefinition errors; less than one, and its
> undefined.

I tried that, and it didn't help.



-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
