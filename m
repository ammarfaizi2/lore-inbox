Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290125AbSBFGWC>; Wed, 6 Feb 2002 01:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290120AbSBFGVw>; Wed, 6 Feb 2002 01:21:52 -0500
Received: from queen.bee.lk ([203.143.12.182]:56961 "EHLO queen.bee.lk")
	by vger.kernel.org with ESMTP id <S290125AbSBFGVg>;
	Wed, 6 Feb 2002 01:21:36 -0500
Date: Wed, 6 Feb 2002 12:22:38 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Christian Koenig <"ChristianK."@t-online.de>
Cc: Anuradha Ratnaweera <anuradha@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] kernelconf-0.1.2
Message-ID: <20020206122238.B17324@bee.lk>
In-Reply-To: <20020124124548.A2435@lklug.pdn.ac.lk> <16YBk1-1gvG08C@fwd07.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16YBk1-1gvG08C@fwd07.sul.t-online.com>; from "ChristianK."@t-online.de on Tue, Feb 05, 2002 at 09:01:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2002 at 09:01:17PM +0100, Christian Koenig wrote:
> 
> The atachmend is a little beta/patch to your kernelconf.  It adds xconfig
> capability to kernelconf, by using Tcl/Tk scripts.  It's still a little bit
> beta, but the main parts like config file loading/storing, menu-deps ... are
> implemented.

Thanks.

I will include it _after_ the next release (0.1.3) which will come out within a
couple of days.  Structure of kernelconf has changed a bit, so we will have to
do some sync.  Also, binaries for each type of config are seperate.

BTW, seems as if you have forgotton to `make clean' before making the patch ;)

	Anuradha

-- 

Debian GNU/Linux (kernel 2.4.17)

If you can't get your work done in the first 24 hours, work nights.

