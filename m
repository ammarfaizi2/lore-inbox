Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161104AbWJDHRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161104AbWJDHRx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 03:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbWJDHRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 03:17:53 -0400
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:26801 "EHLO
	aa011msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1161104AbWJDHRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 03:17:53 -0400
Date: Wed, 4 Oct 2006 09:16:58 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Arkadiusz =?UTF-8?B?SmHFgm93?= =?UTF-8?B?aWVj?= 
	<ajalowiec@interia.pl>,
       <linux-kernel@vger.kernel.org>, <linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] PROBLEM: Kernel 2.6.x freeze
Message-ID: <20061004091658.618037d7@localhost>
In-Reply-To: <20061004091419.455f4185@localhost>
References: <20061003215200.0d1047db@localhost>
	<Pine.LNX.4.44L0.0610031629310.5817-100000@iolanthe.rowland.org>
	<20061004091419.455f4185@localhost>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 09:14:19 +0200
Paolo Ornati <ornati@fastwebnet.it> wrote:

> So one obvious test that Arkadiusz can make is to try to crash 2.6.18
> without using his modem: just detach the USB cable before boot so the
> driver isn't loaded (and even if it's loaded by a "modprobe" in
> init scripts, it can't do much).

Note for Arkadiusz: you don't have to stay on the textual console to
capture another Oops. Do whatever you want and just tell if it crash or
not.

-- 
	Paolo Ornati
	Linux 2.6.18 on x86_64
