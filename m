Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135277AbRECWU4>; Thu, 3 May 2001 18:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135281AbRECWUr>; Thu, 3 May 2001 18:20:47 -0400
Received: from marine.sonic.net ([208.201.224.37]:37124 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S135277AbRECWUh>;
	Thu, 3 May 2001 18:20:37 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Thu, 3 May 2001 15:20:32 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: CML2 <linux-kernel@vger.kernel.org>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, Urban Widmark <urban@teststation.com>,
        John Stoffel <stoffel@casc.com>, cate@dplanet.ch,
        Peter Samuelson <peter@cadcamlab.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Hierarchy doesn't solve the problem
Message-ID: <20010503152031.A27366@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Urban Widmark <urban@teststation.com>,
	John Stoffel <stoffel@casc.com>, cate@dplanet.ch,
	Peter Samuelson <peter@cadcamlab.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010503030431.A25141@thyrsus.com> <Pine.LNX.4.30.0105030907470.28400-100000@cola.teststation.com> <20010503034620.A27880@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.6i
In-Reply-To: <20010503034620.A27880@thyrsus.com>; from esr@thyrsus.com on Thu, May 03, 2001 at 03:46:20AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2001 at 03:46:20AM -0400, Eric S. Raymond wrote:
> What's to prefer?  You get essentially the same behavior unless you start
> with a broken config.

What's going to happen when this interconnected behavior results in a
previously acceptable config becomes broken (by definition) with a later
kernel version?

We're going to have hundreds of people complaining about this.  Not just
one or two.

mrc
-- 
       Mike Castle       Life is like a clock:  You can work constantly
  dalgoda@ix.netcom.com  and be right all the time, or not work at all
www.netcom.com/~dalgoda/ and be right at least twice a day.  -- mrc
    We are all of us living in the shadow of Manhattan.  -- Watchmen
