Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265486AbTFWVNS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 17:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265520AbTFWVNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 17:13:18 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:41990 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S265486AbTFWVNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 17:13:14 -0400
From: Lesley van Zijl <zyl@xs4all.nl>
To: Greg KH <greg@kroah.com>
Subject: Re: usb memory pen broken since 2.5.72?
Date: Mon, 23 Jun 2003 23:26:02 +0000
User-Agent: KMail/1.5.2
References: <200306231803.42338.zyl@xs4all.nl> <20030623182354.GA10089@kroah.com>
In-Reply-To: <20030623182354.GA10089@kroah.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306232326.02007.zyl@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well bk1 was released a few minutes/hours ago, and there aren't any changes 
for usb in there, so I'll wait for bk2 and fill in the bug report right away.

Ow another question what might be a bug or a poorly configured system,
My mp3 player is a usb memory pen too, when i write to it, it can handle 
300/400 kbps, my other memory pen (a real one, so non-mp3) can only handle 
100kbps. is this a bug? or because of the vfat fs ?

On Monday 23 June 2003 18:23, Greg KH wrote:
> On Mon, Jun 23, 2003 at 06:03:42PM +0000, Lesley van Zijl wrote:
> > My USB memory pen stopped working since 2.5.72, the last time it
> > worked for me was 2.5.70.
> >
> > dmesg output on plugin for 2.5.72/73:
>
> Hopefully this is fixed in 2.5.73-bk1 (whenever it shows up.)  Can you
> test that?  If not, can you create a bug in bugzilla.kernel.org for
> this?
>
> thanks,
>
> greg k-h

