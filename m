Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264227AbTCXPWi>; Mon, 24 Mar 2003 10:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264246AbTCXPWi>; Mon, 24 Mar 2003 10:22:38 -0500
Received: from uni03du.unity.ncsu.edu ([152.1.13.103]:1667 "EHLO
	uni03du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id <S264227AbTCXPWh>; Mon, 24 Mar 2003 10:22:37 -0500
From: jlnance@unity.ncsu.edu
Date: Mon, 24 Mar 2003 10:33:44 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030324153344.GA10519@ncsu.edu>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz> <200303231938.h2NJcAq14927@devserv.devel.redhat.com> <20030323194423.GC14750@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030323194423.GC14750@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 08:44:23PM +0100, Martin Mares wrote:

> Do you really think that "People should either use vendor kernels or
> read LKML and be able to gather the fixes from there themselves" is a
> good strategy?

Hi Martin,
    I must say that I think it is an excellent strategy.  I will admit
though, that I have voiced this opinion several times in the past and
it seems that most people disagree with me.
    I think we do a disservice to people by encouraging them to believe
that the kernels they download from kernel.org can be depended on to
work.  Kernel.org kernels are effectivly a way for people to participate
in the development process and to help with QA.  If you dont want to
be involved with these activities, you really do not want to use those
kernels.
    We could try and make that guarantee if we wanted to, but it would
be a lot of work and the vendors are already doing it.  So why not
leverage their work?

Thanks,

Jim
