Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264259AbRFOG4I>; Fri, 15 Jun 2001 02:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264260AbRFOGz7>; Fri, 15 Jun 2001 02:55:59 -0400
Received: from ns.suse.de ([213.95.15.193]:64016 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S264259AbRFOGzr>;
	Fri, 15 Jun 2001 02:55:47 -0400
Date: Fri, 15 Jun 2001 08:55:39 +0200
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Mansfield <lkml@dm.ultramaster.com>,
        lkml <linux-kernel@vger.kernel.org>, jfs-discussion@oss.lotus.com
Subject: Re: [Jfs-discussion] Re: severe FS corruption with 2.4.6-pre2 + IBM jfs 0.3.4 patch
Message-ID: <20010615085539.B23145@gruyere.muc.suse.de>
In-Reply-To: <E15Abh0-000564-00@the-village.bc.nu> <3B290182.42DE3E1@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B290182.42DE3E1@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Jun 14, 2001 at 02:25:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2001 at 02:25:06PM -0400, Jeff Garzik wrote:
> Alan Cox wrote:
> > 
> > > It's probably a JFS issue, but I thought I'd report this in case someone
> > > is collecting and correlating filesystem corruption messages (Alan?).
> > > Here is my sad story.
> > 
> > I get as far as 'using jfs' and delete them
> 
> Understandable but FWIW they have apparently passed a night of
> stress-kernel (cerberus) testing on the latest jfs..

rm -rf not working correctly is a kind of show stopper bug ATM though.
Hopefully it can be fixed soon.

-Andi
