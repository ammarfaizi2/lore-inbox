Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132499AbQKSPU1>; Sun, 19 Nov 2000 10:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132492AbQKSPUS>; Sun, 19 Nov 2000 10:20:18 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:5893 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132485AbQKSPT7>;
	Sun, 19 Nov 2000 10:19:59 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Lang <david.lang@digitalinsight.com>
cc: kraxel@bytesex.org, linux-kernel@vger.kernel.org
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5 
In-Reply-To: Your message of "Sun, 19 Nov 2000 07:16:52 -0800."
             <Pine.LNX.4.21.0011190707340.22457-100000@dlang.diginsite.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 20 Nov 2000 01:49:52 +1100
Message-ID: <7778.974645392@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2000 07:16:52 -0800 (PST), 
David Lang <david.lang@digitalinsight.com> wrote:
>there is a rootkit kernel module out there that, if loaded onto your
>system, can make it almost impossible to detect that your system has been
>compramised. with module support disabled this isn't possible.

Wrong.  There are ways of attacking the kernel even if you have module
support disabled in the kernel.  Disabling modules only makes it a
little harder, do not think for one minute that because you have
disabled modules that you are safe against these root kits, you are
not.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
