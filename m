Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275183AbRJJKBK>; Wed, 10 Oct 2001 06:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275207AbRJJKBB>; Wed, 10 Oct 2001 06:01:01 -0400
Received: from [213.98.126.44] ([213.98.126.44]:7428 "HELO anano.mitica")
	by vger.kernel.org with SMTP id <S275183AbRJJKAo>;
	Wed, 10 Oct 2001 06:00:44 -0400
To: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM on a HP Omnibook XE3
In-Reply-To: <200108301443355.SM00167@there>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <200108301443355.SM00167@there>
Date: 10 Oct 2001 12:01:08 +0200
Message-ID: <m2elobn7a3.fsf@anano.mitica>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "robert" == Robert Szentmihalyi <robert.szentmihalyi@entracom.de> writes:

robert> Hi!
robert> Sorry if this is OT.
robert> I'm not sure if this is a kernel issue, but I'm running out of 
robert> ideas on this....

robert> I have a HP Omnibook XE3 with SuSE Linux 7.2 installed.
robert> Everything works fine except suspend-to-disk.
robert> (I have created the partition. It works under Winblows...)
robert> I have tried Kernels 2.4.4 and 2.4.7 (with SuSE patches) as well as 
robert> 2.4.9 vanilla, but I keep getting the same messages:
robert> When I do
robert> apm -s
robert> I get 
robert> apm: Input/output error
robert> and the Kernel log says:
robert> apm: suspend: Unable to enter requested state


robert> Any ideas what I could do?

For me Fn+F12 works.
apm -s & apm -S fails.

Later, Juan.



-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
