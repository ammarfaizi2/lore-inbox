Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbUKHQwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbUKHQwy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 11:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUKHQuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:50:03 -0500
Received: from smtp1.sloane.cz ([62.240.161.228]:26310 "EHLO smtp1.sloane.cz")
	by vger.kernel.org with ESMTP id S261884AbUKHPZH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 10:25:07 -0500
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsuspend and total loss of all data :(((
Date: Mon, 8 Nov 2004 16:24:52 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200411040126.27613.cijoml@volny.cz> <20041104130228.GE996@openzaurus.ucw.cz>
In-Reply-To: <20041104130228.GE996@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200411081624.52149.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.9 with -mh3 patches

Michal


Dne èt 4. listopadu 2004 14:02 Pavel Machek napsal(a):
> Hi!
>
> > I hibernated without BT donle (CSR based 16.1.1 fw)  plugged into USB
> > port and started with it plugged in and kernel after successfully loaded
> > image from hdd freezes saying USB device plugged in and info about usb
> > port...
> >
> > After press reset kernel started recovering ext3 fs, but all my data are
> > lost...
> >
> > PLS fix it in future releases
>
> Hmm, which kernel was it? Any patches applied?
>     Pavel
