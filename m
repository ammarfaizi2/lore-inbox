Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314477AbSDRWIj>; Thu, 18 Apr 2002 18:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314478AbSDRWIi>; Thu, 18 Apr 2002 18:08:38 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:62603 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314477AbSDRWIh>;
	Thu, 18 Apr 2002 18:08:37 -0400
Date: Fri, 19 Apr 2002 08:07:43 +1000
From: Anton Blanchard <anton@samba.org>
To: Robert Love <rml@tech9.net>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Erich Focht <efocht@ess.nec.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>, torvalds@transmeta.com
Subject: Re: [PATCH] migration thread fix
Message-ID: <20020418220743.GB13756@krispykreme>
In-Reply-To: <Pine.LNX.4.44.0204182043110.2453-100000@beast.local> <20020418212851.GW21206@holomorphy.com> <1019166066.5395.99.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I am also curious what causes #1 you mention.  Do you see it in the
> _normal_ code or just with your patch?  

We were getting lockups with 2.5.5ish on the 32 way which #1 fixed.

Anton
