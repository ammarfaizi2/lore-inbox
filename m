Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310660AbSCYPyz>; Mon, 25 Mar 2002 10:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312442AbSCYPyp>; Mon, 25 Mar 2002 10:54:45 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:24448
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S310660AbSCYPyf>; Mon, 25 Mar 2002 10:54:35 -0500
Date: Mon, 25 Mar 2002 08:54:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kain <kain@kain.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] PPC syscalls for XFS
Message-ID: <20020325155432.GA3667@opus.bloom.county>
In-Reply-To: <20020325131032.GC24094@noir.is.pn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 07:10:32AM -0600, Kain wrote:

> To whom it may concern, I'd like to get some PPC syscalls reserved for
> XFS xattr support, with syscalls #226-#237 to the xattr support; this is
> the same position and range that is used for these syscalls on i386.

Try sending this to linuxppc-dev@lists.linuxppc.org.  Also, aren't these
already done in 2.5, where iirc, the x86 syscalls are as well?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
