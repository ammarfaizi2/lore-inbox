Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135172AbRDVCXY>; Sat, 21 Apr 2001 22:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135173AbRDVCXE>; Sat, 21 Apr 2001 22:23:04 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:19460 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135172AbRDVCWw>;
	Sat, 21 Apr 2001 22:22:52 -0400
Date: Sat, 21 Apr 2001 22:23:07 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Request for comment -- a better attribution system
Message-ID: <20010421222307.A15644@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	"Mr. James W. Laferriere" <babydr@baby-dragons.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.32.0104211456540.4237-100000@filesrv1.baby-dragons.com> <200104220033.f3M0XsM162528@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104220033.f3M0XsM162528@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Sat, Apr 21, 2001 at 08:33:53PM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan <acahalan@cs.uml.edu>:
> The above would grep every file. It takes 1 minute and 9.5 seconds.
> So the distributed maintainer information does not scale well at all.

There is an easy solution to this which I will demonstrate with code.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Everything that is really great and inspiring is created by the
individual who can labor in freedom.
	-- Albert Einstein, in H. Eves Return to Mathematical Circles, 
		Boston: Prindle, Weber and Schmidt, 1988.
