Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271409AbRHOUVh>; Wed, 15 Aug 2001 16:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271407AbRHOUVS>; Wed, 15 Aug 2001 16:21:18 -0400
Received: from ns.caldera.de ([212.34.180.1]:59292 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S271409AbRHOUVD>;
	Wed, 15 Aug 2001 16:21:03 -0400
Date: Wed, 15 Aug 2001 22:20:30 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: lvm-devel@sistina.com
Cc: Joe Thornber <thornber@btconnect.com>, Kurt Garloff <garloff@suse.de>,
        linux-lvm@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] Re: [linux-lvm] Re: *** ANNOUNCEMENT *** LVM 1.0 available at www.sistina.com
Message-ID: <20010815222030.A23962@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>, lvm-devel@sistina.com,
	Joe Thornber <thornber@btconnect.com>,
	Kurt Garloff <garloff@suse.de>, linux-lvm@sistina.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010815175659.A29749@sistina.com> <20010815182548.U3941@gum01m.etpnet.phys.tue.nl> <20010815185005.A32239@sistina.com> <20010815190428.A11146@athlon.random> <20010815210622.A1221@btconnect.com> <20010815221623.C11146@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010815221623.C11146@athlon.random>; from andrea@suse.de on Wed, Aug 15, 2001 at 10:16:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2001 at 10:16:23PM +0200, Andrea Arcangeli wrote:
> You can put the algorithm used by beta7 in a separate program and ask
> this program where the pe start. Since the beta7 tools knows where the
> pe_start (the proof is that I can use lvm in my machines), also this new
> program will know where the pe_start.

In principle yes, but beta7 is the wrong target, the one that needs to
be converted easily is the old (=0.9) format, people using betas should
really know what they are doing while a seamless upgrade from the latest
release version is a must.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
