Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292603AbSBZSDl>; Tue, 26 Feb 2002 13:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292585AbSBZSDZ>; Tue, 26 Feb 2002 13:03:25 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:4084
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292478AbSBZSDC>; Tue, 26 Feb 2002 13:03:02 -0500
Date: Tue, 26 Feb 2002 10:03:44 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: "Rose, Billy" <wrose@loislaw.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020226180344.GP4393@matchmail.com>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	"Rose, Billy" <wrose@loislaw.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD063077D8@loisexc2.loislaw.com> <3C7BCB9B.7050207@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C7BCB9B.7050207@evision-ventures.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 06:53:31PM +0100, Martin Dalecki wrote:
> Rose, Billy wrote:
> >"So the pain for the sysadmin will certainly not be decreased."
> >
> >My company can tolerate 0% loss of data (which is why I raised this issue).
> >The sysadmin's pain would be standing in the unemployment line if a file
> >could not be recovered (which is currently from a heap of tapes that may
> >take many hours to locate). The issue is not an easier job, but data
> >integrity. Any sysadmin would state that every user at some point in time
> >will delete something that is critical. Hell, I've done it myself on my own
> >workstation after staring at the screen for 15 hours on a Saturday. The
> >ability to handle situations like a file going "poof" is why my company 
> >will
> >not use Linux on these particular file servers. My aim was to change that 
> >by
> >crushing the only thing holding Netware in my company.
> 
> Ever tought of adding some *archiving* features to samba - fully
> transparent to the users and still no need to mess around with the
> kernel? And last but not least - much easier to implement correctly,
> if the only thing you wan't is to crash netware...

Ahh, so now you only get undelete if you deleted it through samba, or nfs or
ftp, but not from anywhere else...

Also, this doesn't have to touch the kernel *at all*.

Mike
