Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261614AbTCVAEo>; Fri, 21 Mar 2003 19:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbTCVAEo>; Fri, 21 Mar 2003 19:04:44 -0500
Received: from bitmover.com ([192.132.92.2]:21954 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261614AbTCVAEn>;
	Fri, 21 Mar 2003 19:04:43 -0500
Date: Fri, 21 Mar 2003 16:15:40 -0800
From: Larry McVoy <lm@bitmover.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030322001540.GA6309@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0303161341520.5348-100000@xanadu.home> <20030317215639.GG15658@atrey.karlin.mff.cuni.cz> <20030317220830.GM1324@dualathlon.random> <20030321141620.GA25142@work.bitmover.com> <b5fpra$rdb$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5fpra$rdb$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 11:40:26AM -0800, H. Peter Anvin wrote:
> Followup to:  <20030321141620.GA25142@work.bitmover.com>
> By author:    Larry McVoy <lm@bitmover.com>
> In newsgroup: linux.dev.kernel
> > 
> > HPA, should we be mirroring the CVS tarballs to kernel.org?
> > 
> 
> That would be highly useful.  I would also like to see the bk export
> text file, whatever it's called, mirrored there.

There is no bk export text file, the output of the export is the CVS
repository, there isn't anything else.  Everything that we could 
extract has been extracted and put in CVS.  It's a fairly complete
and accurate extraction, too.  Far more than the traditional releases
and pre-releases, I don't know how many of those there have been in
the 2.5 timeframe but I can't imagine more than a couple hundred;
there are 8500 commits in the 2.5 CVS tree.  
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
