Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbTAaXap>; Fri, 31 Jan 2003 18:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbTAaXap>; Fri, 31 Jan 2003 18:30:45 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:7404 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S263321AbTAaXao>;
	Fri, 31 Jan 2003 18:30:44 -0500
Date: Sat, 1 Feb 2003 00:40:09 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "J.A. Magallon" <jamagallon@able.es>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Perl in the toolchain
Message-ID: <20030131234009.GC1541@werewolf.able.es>
References: <20030131133929.A8992@devserv.devel.redhat.com> <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu> <20030131194837.GC8298@gtf.org> <20030131213827.GA1541@werewolf.able.es> <20030131222257.GA11011@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030131222257.GA11011@mars.ravnborg.org>; from sam@ravnborg.org on Fri, Jan 31, 2003 at 23:22:57 +0100
X-Mailer: Balsa 2.0.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.01.31 Sam Ravnborg wrote:
> On Fri, Jan 31, 2003 at 10:38:27PM +0100, J.A. Magallon wrote:
[...]
> > instead of
> > - do all parsing in perl, that is what perl is for and what is mainly done
> >   in kconfig scripts
> flex and bison is better for this job.

Sure ? KConfig syntax is now context-dependent or the like ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre4-jam1 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-5mdk))
