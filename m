Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129946AbQKHU76>; Wed, 8 Nov 2000 15:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129941AbQKHU7s>; Wed, 8 Nov 2000 15:59:48 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:51729 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129939AbQKHU7j>;
	Wed, 8 Nov 2000 15:59:39 -0500
Date: Wed, 8 Nov 2000 12:59:53 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Network error
Message-ID: <Pine.LNX.4.21.0011081258310.259-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Something I seen on a lug. Anyone have a patch for this?

I'm trying to compile a 2.2.17 kernel.  When I do a make bzImage, I get
this error.  It seems to be centering on networking areas (nfs, svclock,
tcp, etc.)

tcp_input.c:1393:52: warning: pasting would not give a valid preprocessing
token
tcp_input.c:1441:85: warning: pasting would not give a valid preprocessing
token

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
