Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267921AbUHKJeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267921AbUHKJeh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 05:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUHKJeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 05:34:37 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:44192 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S267921AbUHKJef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 05:34:35 -0400
X-Sender-Authentication: net64
Date: Wed, 11 Aug 2004 11:34:32 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: dwmw2@infradead.org, James.Bottomley@steeleye.com,
       alan@lxorguk.ukuu.org.uk, axboe@suse.de, eric@lammerts.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-Id: <20040811113432.40753d48.skraw@ithnet.com>
In-Reply-To: <200408101528.i7AFS4Dh014332@burner.fokus.fraunhofer.de>
References: <200408101528.i7AFS4Dh014332@burner.fokus.fraunhofer.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004 17:28:04 +0200 (CEST)
Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:

> 
> >From: David Woodhouse <dwmw2@infradead.org>
> >> Look into the mkisofs source, I even needed to include a comment in hope
> >to> prevent people from SuSE to convert legal and correct C code into a
> >broken> piece of code just because  they modify things they don't understand
> >:-(
> 
> >Funny that; they _all_ fail to co-operate, even though they all manage
> >to co-operate with most other upstream authors. It's probably best that
> 
> Looks like you never asked other Authors :-(
> 
> I received complaints about similat problem to the one I have from the author
> of xcdroast.

Ohh, real great mention!
That is the guy that refuses to include minimum support for other burning tools
(i.e. not cdrecord) into his application, right? Great for him, and a good
reason to use k3b instead.

Regards,
Stephan
