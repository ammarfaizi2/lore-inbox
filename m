Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319256AbSHUX45>; Wed, 21 Aug 2002 19:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319257AbSHUX45>; Wed, 21 Aug 2002 19:56:57 -0400
Received: from codepoet.org ([166.70.99.138]:38877 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S319256AbSHUX45>;
	Wed, 21 Aug 2002 19:56:57 -0400
Date: Wed, 21 Aug 2002 18:01:07 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac6
Message-ID: <20020822000107.GB26956@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>,
	linux-kernel@vger.kernel.org
References: <200208212025.g7LKPda15450@devserv.devel.redhat.com> <20020821234411.GA26772@codepoet.org> <1029973994.26533.269.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029973994.26533.269.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 22, 2002 at 12:53:14AM +0100, Alan Cox wrote:
> On Thu, 2002-08-22 at 00:44, Erik Andersen wrote:
> > On Wed Aug 21, 2002 at 04:25:39PM -0400, Alan Cox wrote:
> > > IDE status
> > > 	Chasing two reports of strange ide-scsi crashes
> > > 	Still some Promise glitches - need to review merge carefully
> > 
> > Its doesn't understand that I indeed am using 80 pin cables for
> > the drives connected to my Promise 20267 controller.  Also, it would
> > be nice to clean up the formatting on the "80-pin cable" message to
> > keep it from wrapping.
> 
> There is a detection logic error somewhere in the promise driver. Its on
> the list to look at if Andre doesnt find it or solve it when he splits
> the promise into two drivers (old and new style). If 2.4.20pre2-ac2
> worked then it won't be too hard to chase out.

Cant say whether 2.4.20pre2-ac2 worked, but 2.4.20-pre1-ac3
worked just fine...  Want me to test 2.4.20pre2-ac2 also?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
