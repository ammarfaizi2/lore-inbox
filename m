Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263252AbUC3GMM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 01:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263253AbUC3GMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 01:12:12 -0500
Received: from imap.gmx.net ([213.165.64.20]:58570 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263252AbUC3GMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 01:12:09 -0500
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.5-rc3
Date: Tue, 30 Mar 2004 08:14:21 +0200
User-Agent: KMail/1.6.1
References: <Pine.LNX.4.58.0403292129200.1096@ppc970.osdl.org> <40690B84.7060203@cornell.edu>
In-Reply-To: <40690B84.7060203@cornell.edu>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403300814.21205.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Take a look in your config file, if 4KSTACK is enabled, it shouldn't.

btw, the 2.6.5-rc3 isn't displayed on the www.kernel.org frontpage!?


On Tuesday 30 March 2004 07:54, you wrote:
> Linus Torvalds wrote:
> > x86-64, arm, ppc64, ia64, s390 updates.
> >
> > And agp, acpi, ISDN and watchdog.
> >
> > Nothing earth-shattering, in other words.
>
> My binary-only proprietary unfree Nvidia driver is broken (and works on
> 2.6.4). What are some interesting changeset numbers to try to locate the
> exact cause?
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
