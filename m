Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264303AbRGGAhf>; Fri, 6 Jul 2001 20:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264361AbRGGAhO>; Fri, 6 Jul 2001 20:37:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52456 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264303AbRGGAhK>;
	Fri, 6 Jul 2001 20:37:10 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15174.22965.347920.402183@pizda.ninka.net>
Date: Fri, 6 Jul 2001 17:37:09 -0700 (PDT)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why Plan 9 C compilers don't have asm("")
In-Reply-To: <9i5kdp$qvs$1@cesium.transmeta.com>
In-Reply-To: <200107061724.NAA14777@smarty.smart.net>
	<15174.20383.84051.790269@pizda.ninka.net>
	<9i5kdp$qvs$1@cesium.transmeta.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


H. Peter Anvin writes:
 > Believe it or not, that's actually a fairly simple part of the whole
 > machinery.  All you need for that is to maintain a call/return stack
 > in the front end of the pipe.

I understand how RAS stacks work, I even mentioned them in another
posting of this thread :-)  It's the CALL _itself_ that I'm talking
about.

Later,
David S. Miller
davem@redhat.com
