Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132389AbQKKUS3>; Sat, 11 Nov 2000 15:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132360AbQKKUST>; Sat, 11 Nov 2000 15:18:19 -0500
Received: from slc602.modem.xmission.com ([166.70.7.94]:23303 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S132388AbQKKUSN>; Sat, 11 Nov 2000 15:18:13 -0500
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: Q: Linux rebooting directly into linux.
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org> <3A0ABB0C.99075A61@holly-springs.nc.us>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Nov 2000 12:46:51 -0700
In-Reply-To: Michael Rothwell's message of "Thu, 09 Nov 2000 09:56:12 -0500"
Message-ID: <m1k8aacmvo.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rothwell <rothwell@holly-springs.nc.us> writes:

> "Eric W. Biederman" wrote:
> > 
> > I have recently developed a patch that allows linux to directly boot
> > into another linux kernel.  
> 
> This would rock. One place I can think of using it is with distro
> installers. The installer boots a generic i386 kernel, and then installs
> an optimized (i.e, PIII, etc.) kernel for run-time.

This would rock?  It already does.  Of course the installers need
to actually uses this.

Eric


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
