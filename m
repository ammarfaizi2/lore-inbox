Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130900AbQKGLUV>; Tue, 7 Nov 2000 06:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131219AbQKGLUM>; Tue, 7 Nov 2000 06:20:12 -0500
Received: from ha1.rdc2.nsw.optushome.com.au ([203.164.2.50]:55994 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S130900AbQKGLUF>; Tue, 7 Nov 2000 06:20:05 -0500
Message-ID: <3A07E600.FC1E089B@optushome.com.au>
Date: Tue, 07 Nov 2000 22:22:40 +1100
From: Joel Beach <joelbeach@optushome.com.au>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Slow screen redraw in 2.4.x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed noticeably slower screen refresh in 2.4.x than under the
2.2 kernel series. It's most noticeable when running xscreensaver with
fast scrolling patterns, or when doing opague moves of large windows.
I'm using Xfree 4.01 and the XFree driver for the Nvidia card (not the
Nvidia binary package).

This has been happening to me since the earliest 2.3.99 kernels, but it
isn't really a very scientific observation, so I thought I'd wait and
see if performance improved. It hasn't, so I thought I'd post it here to
hear other people's thoughts on it.

Would it have anything to do with shm performance under 2.4. I read that
Rik said that it wasn't really as good as it could be. Does that mean
that it should be slower than under 2.2 though?

Sorry for my cluelessness. Tell me to get lost if this doesn't belong
here, or let me know what tests I should run which would give a number
to these observations.

Thanks

Joel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
