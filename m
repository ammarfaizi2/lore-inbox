Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275942AbSIUUOM>; Sat, 21 Sep 2002 16:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275943AbSIUUOM>; Sat, 21 Sep 2002 16:14:12 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:33005 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S275942AbSIUUOL>;
	Sat, 21 Sep 2002 16:14:11 -0400
Date: Sat, 21 Sep 2002 22:19:11 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       msinz@wgate.com
Subject: Re: [PATCH] kernel 2.4.19 & 2.5.38 - coredump sysctl
Message-ID: <20020921221911.C15732@fafner.intra.cogenit.fr>
References: <3D8B87C7.7040106@wgate.com.suse.lists.linux.kernel> <3D8B8CAB.103C6CB8@digeo.com.suse.lists.linux.kernel> <3D8B934A.1060900@wgate.com.suse.lists.linux.kernel> <3D8B982A.2ABAA64C@digeo.com.suse.lists.linux.kernel> <p73bs6stfv8.fsf@oldwotan.suse.de> <3D8BAEDC.ED943632@digeo.com> <20020921014735.A28162@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020921014735.A28162@wotan.suse.de>; from ak@suse.de on Sat, Sep 21, 2002 at 01:47:35AM +0200
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> :
> On Fri, Sep 20, 2002 at 04:27:24PM -0700, Andrew Morton wrote:
[...]
> > Oh sure, I agree that it's a useful feature.  But I don't agree that
> > we need to allow users to specify how the final filename is pasted
> > together.  Just give them host-uid-gid-comm.core.  ie: everything.
> 
> That wouldn't support the Dr.Watson thing.

Time to upgrade to directory notification enabled Dr.Watson ?

-- 
Ueimor
