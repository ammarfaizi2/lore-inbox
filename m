Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290860AbSARWm6>; Fri, 18 Jan 2002 17:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290861AbSARWmu>; Fri, 18 Jan 2002 17:42:50 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:62625 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290860AbSARWmf>; Fri, 18 Jan 2002 17:42:35 -0500
Subject: Re: FC & MULTIPATH !? (any hope?)
From: Brian Beattie <alchemy@us.ibm.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Mario Mikocevic <mozgy@hinet.hr>, linux-kernel@vger.kernel.org
In-Reply-To: <20020118080714.I937@marowsky-bree.de>
In-Reply-To: <20020114123301.B30997@danielle.hinet.hr>
	<1011310615.519.3.camel@w-beattie1>  <20020118080714.I937@marowsky-bree.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 18 Jan 2002 14:30:11 -0800
Message-Id: <1011393012.466.2.camel@w-beattie1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-17 at 23:07, Lars Marowsky-Bree wrote:
> On 2002-01-17T15:36:54,
>    Brian Beattie <alchemy@us.ibm.com> said:
> 
> > Probable enhancements to this would include, provideing a method to mark
> > a path to not attempt this crude form of auto recovery and a way to mark
> > a failed path as good.  Finally a device wide flag to disable
> > auto-recovery.
...
> 
> Combined with the enhancements this makes a lot of sense.
> 
> The enhancements are very much required, especially the way to mark a path as
> good again manually.
> 
> I would also liks easily parseable /proc file to query the status of a
> multi-path device, including all paths associated with it.
> 
> 
I have some stuff that uses sysctl, which shows in /proc/sys/... that I
was planning to use.


