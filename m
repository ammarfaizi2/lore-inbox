Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSGXJiy>; Wed, 24 Jul 2002 05:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316499AbSGXJiy>; Wed, 24 Jul 2002 05:38:54 -0400
Received: from ns.suse.de ([213.95.15.193]:15371 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315746AbSGXJix>;
	Wed, 24 Jul 2002 05:38:53 -0400
Date: Wed, 24 Jul 2002 11:42:04 +0200
From: Dave Jones <davej@suse.de>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  July 24, 2002
Message-ID: <20020724114204.G16446@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	James Simmons <jsimmons@transvirtual.com>,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	linux-kernel@vger.kernel.org
References: <3D3DDB50.22836.49DD0EB@localhost> <Pine.LNX.4.44.0207232206300.24482-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207232206300.24482-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Tue, Jul 23, 2002 at 10:21:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 10:21:08PM -0700, James Simmons wrote:
 > 
 > > o in -dj      Rewrite of the console layer                    (James Simmons)
 > 
 > It was introduce in 2.5.25.

But there are still some sizable chunks of it in my tree pending merge.
I went through yesterday and threw out a lot of whitespace noise, but
there are still some 'functional' diffs there that need either pushing
to Linus, or dropping. From the look of the ones I skimmed, they need
to go to Linus, but I'll let you decide.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
