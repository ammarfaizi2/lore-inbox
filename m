Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280970AbRKDSCk>; Sun, 4 Nov 2001 13:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281060AbRKDSCa>; Sun, 4 Nov 2001 13:02:30 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:61962 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S280970AbRKDSCM>; Sun, 4 Nov 2001 13:02:12 -0500
Date: Sun, 4 Nov 2001 18:02:09 +0000
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Cc: Jakob =?iso-8859-1?Q?=D8stergaard?= <jakob@unthought.net>,
        Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104180209.B91628@compsoc.man.ac.uk>
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160Nyq-2ACgt6C@fmrl07.sul.t-online.com> <20011104163354.C14001@unthought.net> <160QM5-1HAz5sC@fmrl00.sul.t-online.com> <20011104184839.F14001@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011104184839.F14001@unthought.net>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 06:48:39PM +0100, Jakob Østergaard wrote:

> Where's the policy ?   The only policy I see is the text-mode GUI in the
> existing proc interface

well exactly

> - and that is one place where I actually *like* the
> policy as a user (sysadmin)

"meminfo" versus "cat /proc/meminfo" is not too great a leap in 2.7, when
the back-compat stuff gets dropped.

regards
john

-- 
"All this just amounts to more grist for the mill of the ill."
	- Elizabeth Wurtzel
