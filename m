Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262903AbSJLLe5>; Sat, 12 Oct 2002 07:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262905AbSJLLe5>; Sat, 12 Oct 2002 07:34:57 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:33043 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S262903AbSJLLe4>; Sat, 12 Oct 2002 07:34:56 -0400
Date: Sat, 12 Oct 2002 04:40:36 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.42
Message-ID: <20021012114036.GB22536@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com> <20021012095026.GC28537@merlin.emma.line.org> <20021012111140.GA22536@pegasys.ws> <1034423197.14382.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034423197.14382.2.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 12:46:37PM +0100, Alan Cox wrote:
> On Sat, 2002-10-12 at 12:11, jw schultz wrote:
> > So far everything indicates that LVM2 is not compatible with
> > LVM.  That LVM2 and LVM(1) can coexist-exist is irrelevant if
> > 2.5 hasn't got a working LVM(1).  And that would leave us
> > with having to do backup+restore around the upgrade.
> 
> LVM2 supports LVM1 volumes. I don't know where you got the idea
> otherwise. 

Good.  I'm very glad to be wrong.  Then all we need care
about is project maturity and design.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
