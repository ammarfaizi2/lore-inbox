Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267339AbTAGIGK>; Tue, 7 Jan 2003 03:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267340AbTAGIGK>; Tue, 7 Jan 2003 03:06:10 -0500
Received: from almesberger.net ([63.105.73.239]:1798 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267339AbTAGIGI>; Tue, 7 Jan 2003 03:06:08 -0500
Date: Tue, 7 Jan 2003 05:14:41 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Message-ID: <20030107051441.A18502@almesberger.net>
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org> <3E19B401.7A9E47D5@linux-m68k.org> <17360000.1041899978@localhost.localdomain> <20030107042045.GA10045@waste.org> <200301070538.h075cICR004033@turing-police.cc.vt.edu> <20030107031638.D1406@almesberger.net> <200301070643.h076hWCR004411@turing-police.cc.vt.edu> <20030107040829.E1406@almesberger.net> <200301070800.h0780ECR005255@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301070800.h0780ECR005255@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Tue, Jan 07, 2003 at 03:00:14AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> "without".  Let's say it takes 4 hours to recover from a drop, and
> you have another one 3 hours into recovery - it will now take more than
> one more hour to recover.

Ah, now I understand what you meant. I read that as "even if there is
no drop at all, it can take hours".

> The whole slow-start/ack/retransmit has been chewed over so many times in the
> last 20 years that it's hard to keep track of which vendors picked up which
> tweaks when, and which vendors accidentally invented them again, and which
> vendors invented the tweaks independently and didn't publicize them more....

... or figure out which combination of RFCs, I-Ds, and ad hoc genius
makes up Linux TCP, yes ;-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
