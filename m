Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129543AbQLKIxy>; Mon, 11 Dec 2000 03:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbQLKIxo>; Mon, 11 Dec 2000 03:53:44 -0500
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:17288 "EHLO
	altrade.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S129543AbQLKIxk>; Mon, 11 Dec 2000 03:53:40 -0500
Date: Mon, 11 Dec 2000 09:21:30 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: Guest section DW <dwguest@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11 EXT2 corruption (closed)
Message-ID: <20001211092130.A9129@iapetus.localdomain>
In-Reply-To: <20001210161723.A1060@iapetus.localdomain> <20001210183101.A6947@iapetus.localdomain> <20001210213500.A17413@iapetus.localdomain> <20001210224402.A913@iapetus.localdomain> <20001211013736.A18862@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20001211013736.A18862@win.tue.nl>; from dwguest@win.tue.nl on Mon, Dec 11, 2000 at 01:37:36AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2000 at 01:37:36AM +0100, Guest section DW wrote:
> 
> I see lots of messages from you about corruption in 2.4.0-test11
> but we all know very well that 2.4.0-test11 corrupts things
> and further evidence is not necessary.
> Hopefully all, or at least the most significant, problems
> have been solved now, so you should upgrade to the most
> recent test kernel and see how things are there.
> 
Thanks. test12-pre7 fixes this for me: it ran all night testing and
no problems so far.

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
