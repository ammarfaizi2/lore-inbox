Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbUDEXRg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 19:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUDEXRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 19:17:36 -0400
Received: from linux-bt.org ([217.160.111.169]:30387 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S263281AbUDEXRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 19:17:34 -0400
Subject: Re: regression: oops with usb bcm203x bluetooth dongle 2.6.5
From: Marcel Holtmann <marcel@holtmann.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1081201957.3590.49.camel@localhost>
References: <1081196482.3591.5.camel@localhost>
	 <1081199370.2843.20.camel@pegasus>  <1081200442.3591.38.camel@localhost>
	 <1081201227.2843.27.camel@pegasus>  <1081201957.3590.49.camel@localhost>
Content-Type: text/plain
Message-Id: <1081207065.17215.6.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 06 Apr 2004 01:17:45 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Soeren,

> That is why I removed all the bluefw stuff in /etc/hotplug before
> testing bluetooth again... but it still oopsed.

maybe you wanna try 2.6.5-mh1 from http://www.bluez.org/patches.html

Regards

Marcel


