Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133055AbRBRRLA>; Sun, 18 Feb 2001 12:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133063AbRBRRKv>; Sun, 18 Feb 2001 12:10:51 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:49677 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S133055AbRBRRKd>; Sun, 18 Feb 2001 12:10:33 -0500
Date: Sun, 18 Feb 2001 12:10:19 -0500
From: Chris Mason <mason@suse.com>
To: Frank de Lange <frank@unternet.org>
cc: linux-kernel@vger.kernel.org, reiser@namesys.com
Subject: Re: reiserfs on 2.4.1,2.4.2-pre (with null bytes patch) breaks
 mozilla compile
Message-ID: <1336530000.982516219@tiny>
In-Reply-To: <20010218030727.C13823@unternet.org>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, February 18, 2001 03:07:27 AM +0100 Frank de Lange
<frank@unternet.org> wrote:
> 
> And no, I'm not running RedHat 7.x for those who might think so (and
> automatically blame everything on it).
> 

Minor nit, but I'd rather clear it up now.  Which distribution you run
doesn't matter for debugging.  What does matter is that we've got known
problems with a given compiler, and that compiler goes by a few different
flavors with the same version number.  Since there are known problems, if
you don't provide the compiler version, I'll ask.  If your bug is *really*
odd, I might ask a few different ways, just to make sure you give the same
answer every time ;-)

-chris

