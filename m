Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278527AbRJSQCF>; Fri, 19 Oct 2001 12:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278530AbRJSQBz>; Fri, 19 Oct 2001 12:01:55 -0400
Received: from femail11.sdc1.sfba.home.com ([24.0.95.107]:26363 "EHLO
	femail11.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S278527AbRJSQBn>; Fri, 19 Oct 2001 12:01:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Naren Devaiah <naren.devaiah@home.com>
To: Peter Moscatt <pmoscatt@yahoo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can't see IDE CDR-W after compile ?
Date: Fri, 19 Oct 2001 09:00:24 -0700
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20011019133553.21616.qmail@web14707.mail.yahoo.com>
In-Reply-To: <20011019133553.21616.qmail@web14707.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011019160216.VNQQ4652.femail11.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 October 2001 06:35 am, Peter Moscatt wrote:
> I have recently compiled 2.4.10 onto my Mandrake 8.0
> installation.
>
> Since then I now can't access my CD burner, but am
> able to mount my normal IDE CDRom.
>
> As a matter of interest, I disabled the SCSII support
> - do I need to reinstate this option ?

Yes. SCSI emulation/SCSI CDROM support is required for cdrecord etc to work.

-Naren
