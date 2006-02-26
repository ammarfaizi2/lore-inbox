Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWBZWu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWBZWu2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 17:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWBZWu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 17:50:28 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:59572 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751419AbWBZWu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 17:50:28 -0500
Subject: Re: Building 100 kernels; we suck at dependencies and drown in
	warnings
From: Lee Revell <rlrevell@joe-job.com>
To: Nix <nix@esperi.org.uk>
Cc: Al Viro <viro@ftp.linux.org.uk>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <87fym53g5m.fsf@hades.wkstn.nix>
References: <200602261721.17373.jesper.juhl@gmail.com>
	 <1140986578.24141.141.camel@mindpipe> <87wtfh3i9z.fsf@hades.wkstn.nix>
	 <20060226221401.GS27946@ftp.linux.org.uk>  <87fym53g5m.fsf@hades.wkstn.nix>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 17:50:19 -0500
Message-Id: <1140994219.24141.197.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 22:32 +0000, Nix wrote:
> On Sun, 26 Feb 2006, Al Viro moaned:
> > On Sun, Feb 26, 2006 at 09:46:32PM +0000, Nix wrote:
> >> (i.e., there's a reason that warning uses the word *might*.)
> > 
> > The bug is in spewing tons of false positives, reducing S/N on that
> > warning to nearly useless level.  Note that in this case actually
> > missing some would be more useful if what remains is less diluted
> > by crap.
> 
> I think this might be <http://gcc.gnu.org/PR5035>.
> 

Al posted a quite compelling analysis of this bug a while back that's
much better than anything in that bug report, of course I can't find it
right now.

Lee

