Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264948AbUELCiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264948AbUELCiX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 22:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264952AbUELCiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 22:38:22 -0400
Received: from nevyn.them.org ([66.93.172.17]:27802 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S264948AbUELCiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 22:38:20 -0400
Date: Tue, 11 May 2004 22:38:19 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH 1/2] PPC32: New OCP core support
Message-ID: <20040512023819.GA13812@nevyn.them.org>
Mail-Followup-To: Matt Porter <mporter@kernel.crashing.org>,
	benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.linuxppc.org
References: <20040511170150.A4743@home.com> <20040511175750.12bad316.akpm@osdl.org> <000101c437c2$d7467ac0$d100000a@sbs2003.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101c437c2$d7467ac0$d100000a@sbs2003.local>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 02:45:44AM +0100, Matt Porter wrote:
> 
> On Tue, May 11, 2004 at 05:57:50PM -0700, Andrew Morton wrote:
> > Matt Porter <mporter@kernel.crashing.org> wrote:
> > >
> > > New OCP infrastructure ported from 2.4 along with several
> > > enhancements. Please apply.
> >
> > I only received patch 1/2.
> >
> > Could you please avoid using the same Subject: for different patches?  It
> > confuses my auto-subject-to-patch-filename-munger and it's nice to more
> > specifically identify each patch anwyay.
> 
> Oddly I sent unique subjects:
> 
> 	Subject: [PATCH 1/2] PPC32: New OCP core support
> 	Subject: [PATCH 2/2] PPC32: PPC4xx updates for new OCP
> 
> It appears 2/2 at least made it off my system to the remote mailer,
> will doublecheck.

Your mail is being duplicated by what looks like a broken news gateway,
or something similar, on linuxppc-dev:

Received: from host213-123-250-229.in-addr.btopenworld.com ([213.123.250.229]:15149                     
        "EHLO 2003SERVER.sbs2003.local") by vger.kernel.org with ESMTP                                  
        id S264904AbUELBme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);                               
        Tue, 11 May 2004 21:42:34 -0400                                                                 
Received: from mail pickup service by 2003SERVER.sbs2003.local with Microsoft SMTPSVC;                  
         Wed, 12 May 2004 02:45:44 +0100                                                                

> 
> -Matt
> 
> ** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Daniel Jacobowitz
