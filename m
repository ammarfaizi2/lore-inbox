Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbUDLRfa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 13:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbUDLRfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 13:35:30 -0400
Received: from mout0.freenet.de ([194.97.50.131]:47531 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S262987AbUDLRfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 13:35:24 -0400
Reply-to: Wolfgang Fritz <wolfgang.fritz@gmx.net>
To: linux-kernel@vger.kernel.org
From: Wolfgang Fritz <wolfgang.fritz@gmx.net>
Subject: Re: Where did the USB generic scanner driver go? 2.6.5
Date: Mon, 12 Apr 2004 19:33:20 +0200
Organization: None
Message-ID: <c5ejt0$802$1@fritz38552.news.dfncis.de>
References: <407AC3A1.8090503@mauve.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: en-us, en, de-de
In-Reply-To: <407AC3A1.8090503@mauve.plus.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.11; AVE: 6.25.0.2; VDF: 6.25.0.10; host: gurke)
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.11; AVE: 6.25.0.2; VDF: 6.25.0.10; host: gurke)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Stirling wrote:
> I can't seem to find where this has moved.
> Has it been obsoleted, or removed for some reason?
> Many thanks.
> Ian Stirling.
> -

This driver has been removed from the 2.6 kernel. You have to use libusb
instead. I found the link below helpful:

http://khk.net/sane/libusb.html

Make sure you have a recent sane package installed.

Wolfgang



