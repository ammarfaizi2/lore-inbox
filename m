Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbTEZVxr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 17:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbTEZVxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 17:53:47 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:12776 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262269AbTEZVxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 17:53:46 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Subject: Re: 2.5.69-bk13 USB storage ,few errors
Date: Tue, 27 May 2003 00:07:16 +0200
User-Agent: KMail/1.5.1
Cc: lkml <linux-kernel@vger.kernel.org>
References: <1053972173.1968.18.camel@nalesnik.localhost> <200305262205.38256.oliver@neukum.org> <1053984606.3650.0.camel@nalesnik.localhost>
In-Reply-To: <1053984606.3650.0.camel@nalesnik.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305270007.16492.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 26. Mai 2003 23:30 schrieb Grzegorz Jaskiewicz:
> On Mon, 2003-05-26 at 21:05, Oliver Neukum wrote:
> > > this is sony vaio pcg-c1ve notebook
> > > USB storage on 2.4.21-rc3 does not say anything in dmesg, and works
> > > just perfect.
> >
> > Does it work on 2.5? Your dmesg has no errors.
>
> no, it does not on 2.5.69-bk19
> /dev/scsi dir is empty (devfs)

Do you see it in /proc/scsi/scsi ?

	Regards
		Oliver


