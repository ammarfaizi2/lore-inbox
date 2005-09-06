Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbVIFNa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbVIFNa4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 09:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbVIFNa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 09:30:56 -0400
Received: from verein.lst.de ([213.95.11.210]:19591 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932467AbVIFNaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 09:30:55 -0400
Date: Tue, 6 Sep 2005 15:30:33 +0200
From: "'hch@lst.de'" <hch@lst.de>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'hch@lst.de'" <hch@lst.de>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       "Patro, Sumant" <sumantp@COS1.co.lsil.com>,
       "Kolli, Neela Syam" <knsyam@lsil.com>
Subject: Re: FW: [Fwd: Re: [PATCH scsi-misc 2/2] megaraid_sas: LSI Logic MegaR AID SAS RA ID D river]
Message-ID: <20050906133033.GA30721@lst.de>
References: <0E3FA95632D6D047BA649F95DAB60E57060CD126@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57060CD126@exa-atlanta>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 08:34:07PM -0400, Bagalkote, Sreenivas wrote:
> >  - the ->queuecommand cleanup patch I sent you a awhile ago doesn't
> >    seem to be applied
> 
> I seem to have missed it. I will submit the patch after inclusion

ok, this is really just a small cleanup anyway.

> >  - there's quite a lot of slightly odd formating, it would be nice
> >    if you could run the code through scripts/Lindent.
> 
> I ran Lindent. It looks worse :( I am submitting the Lindent output anyway.
> 
> > 
> > If you could sent out an unmangled patch (even as attachment or on 
> > LSI's ftp side) I'd like to take another, closer look.
> 
> I am sending this from a Linux box. Hopefully, this will comeout clean.
> Sorry for mangled patches.

It's still wrapped, unfortunately.  Let's retry as an attachment.
Anyway, I think we can put the patch in now.  I have a few more really
small things that I'd like to address, I will submit patches as soon
as I have a codebase that I can create patches against.

