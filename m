Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268525AbTBWTDD>; Sun, 23 Feb 2003 14:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268526AbTBWTDC>; Sun, 23 Feb 2003 14:03:02 -0500
Received: from palrel12.hp.com ([156.153.255.237]:8142 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id <S268525AbTBWTDC>;
	Sun, 23 Feb 2003 14:03:02 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15961.7487.465791.980935@napali.hpl.hp.com>
Date: Sun, 23 Feb 2003 11:13:03 -0800
To: David Lang <david.lang@digitalinsight.com>
Cc: Gerrit Huizenga <gh@us.ibm.com>, Benjamin LaHaise <bcrl@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call 
In-Reply-To: <Pine.LNX.4.44.0302222354310.8609-100000@dlang.diginsite.com>
References: <E18moa2-0005cP-00@w-gerrit2>
	<Pine.LNX.4.44.0302222354310.8609-100000@dlang.diginsite.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 23 Feb 2003 00:07:50 -0800 (PST), David Lang <david.lang@digitalinsight.com> said:

  David.L> Garrit, you missed the preior posters point. IA64 had the
  David.L> same fundamental problem as the Alpha, PPC, and Sparc
  David.L> processors, it doesn't run x86 binaries.

This simply isn't true.  Itanium and Itanium 2 have full x86 hardware
built into the chip (for better or worse ;-).  The speed isn't as good
as the fastest x86 chips today, but it's faster (~300MHz P6) than the
PCs many of us are using and it certainly meets my needs better than
any other x86 "emulation" I have used in the past (which includes
FX!32 and its relatives for Alpha).

	--david
