Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264035AbTE0SYm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264050AbTE0SYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:24:41 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:54932 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264035AbTE0SXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:23:52 -0400
Date: Tue, 27 May 2003 15:35:05 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch to add SysRq handling to 3270 console
In-Reply-To: <OFDC120FDF.DF290EFE-ONC1256D33.002E7F84@de.ibm.com>
Message-ID: <Pine.LNX.4.55L.0305271534520.2100@freak.distro.conectiva>
References: <OFDC120FDF.DF290EFE-ONC1256D33.002E7F84@de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 May 2003, Martin Schwidefsky wrote:

>
> > > I considered the updates to be too late for 2.4.21.
> >
> > Too late and TOOO big.
>
> Hmm, last time I sent patches it was 24380 lines. You can argue
> about the dasd patch with 10647 lines which is big but the rest
> is just architecture updates that have accumulated over time.
> And its getting bigger if nothing ever gets integrated. And
> ALL of it is s390 only code. I skipped the common code parts
> which might have caused problems.
>
> The patch I sent to Alan was a bit bigger since it included the
> new tape driver as well (another 12000 lines) and had the latest
> bug fixes as well.
>
> Can we come up with a way to get the s390 stuff into some early
> pre version of 2.4.22 in a way that I have to cut the patches only
> once? It is very frustrating to spent hours doing patch-editing,
> only to have them vanish into nowhere.

Please send me split up patches as soon as 2.4.22-pre is out.
