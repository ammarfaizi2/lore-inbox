Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131362AbRBAXgS>; Thu, 1 Feb 2001 18:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132040AbRBAXgI>; Thu, 1 Feb 2001 18:36:08 -0500
Received: from sherman.pixar.com ([138.72.27.21]:26331 "EHLO sherman.pixar.com")
	by vger.kernel.org with ESMTP id <S131113AbRBAXfu>;
	Thu, 1 Feb 2001 18:35:50 -0500
Message-ID: <3A79F2D0.8AA9F02D@pixar.com>
Date: Thu, 01 Feb 2001 15:35:44 -0800
From: Arun Rao <rao@pixar.com>
Organization: Pixar Animation Studios
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16-3smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Direct (unbuffered) I/O status ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're trying to port some code that currently runs on SGI using the IRIX
direct I/O facility.  From searching the web, it appears that a similar
feature either already is or will soon be available under Linux.  Could
anyone fill me in on what the status is?

(I know about mapping block devices to raw devices, but that alone will
not work for the application we're contemplating: we'd like conventional
file-system support as well as unbuffered I/O capability).

Thanks in advance!

-Arun


--
Arun Rao
Pixar Animation Studios
1200 Park Ave
Emeryville, CA 94608
(510) 752-3526
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
