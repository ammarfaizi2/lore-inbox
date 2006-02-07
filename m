Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWBGBGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWBGBGK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWBGBGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:06:10 -0500
Received: from pproxy.gmail.com ([64.233.166.178]:16178 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932424AbWBGBGJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:06:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cE6TU1iCiK42lrjdFfqREyNHaEQxNsGvlq6ywJeNImgHgB4/YePOa1KJDF+R+yLd+UjT6A5Ap89E15+AbFZCEbjqUlyA3C9zJMN/vllydtR8F4c2Prdar/etpxqM4H5zuHeaguf3wstviVDUtDR7dXe4Wt9K9VhWv88NJyiPNC0=
Message-ID: <964857280602061706n72a9ebbeo9a1930f2b0993e0b@mail.gmail.com>
Date: Mon, 6 Feb 2006 23:06:08 -0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <2@pervalidus.net>
To: Greg KH <greg@kroah.com>
Subject: Re: What causes "USB disconnect" ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060207002749.GA6774@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602062122480.5326@dyndns.pervalidus.net>
	 <20060207002749.GA6774@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/06, Greg KH wrote:
> On Mon, Feb 06, 2006 at 10:15:11PM -0200, Fr?d?ric L. W. Meunier wrote:
> > I never got this messages since I started using 2.6. Today I
> > got it in 2.6.16-rc2. Is this a problem in this version ? How
> > to determine ? I wasn't using the device.
> >
> > Feb  6 20:49:48 pervalidus kernel: usb 1-2: USB disconnect, address 4
>
> The device went away.
>
> > Feb  6 21:01:03 pervalidus kernel: usb 1-2: new low speed USB device using uhci_hcd and address 5
>
> 10 minutes later it came back.
>
> Did you bump the cable?

No.

> It it still working ok?

I think so. I don't do any gaming actually, but tested with jstest and
all buttons are working.

> Did it go into "suspend" mode and just power down, and then later come
> back when you touch it (like a mouse)?

When it happened, his lights turned off. I pressed a button, but
nothing happened. Then, I ignored it and it returned after the minutes
you see from the log.
