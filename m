Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312991AbSDEUMy>; Fri, 5 Apr 2002 15:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313317AbSDEUMo>; Fri, 5 Apr 2002 15:12:44 -0500
Received: from arsenal.visi.net ([206.246.194.60]:8912 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S312991AbSDEUMd>;
	Fri, 5 Apr 2002 15:12:33 -0500
Date: Fri, 5 Apr 2002 15:10:58 -0500
From: Ben Collins <bcollins@debian.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: andreas.bombe@munich.netsurf.de, linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from ieee1394_core release function
Message-ID: <20020405201058.GP29054@blimpo.internal.net>
In-Reply-To: <3CADF6E0.6060402@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 11:11:28AM -0800, Dave Hansen wrote:
> I produced a similar patch for 2.5 which I discussed on the ieee1394 
> mailing list a few weeks ago.  We decided that this was a safe and 
> BKL-free approach.  Here is a patch to do the same thing for 2.4.19-pre6.

Just let me put this into the linux1394 repo, and I'll forward the patch
to Marcello and Linus. Keeps me from having to track 3 sets of changes.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://linux1394.sourceforge.net/
Subversion - http://subversion.tigris.org/
