Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbTIDACG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 20:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264406AbTIDACF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 20:02:05 -0400
Received: from zork.zork.net ([64.81.246.102]:16790 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261853AbTIDACC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 20:02:02 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test 4 and USB
References: <Pine.LNX.3.96.1030903154731.9300A-100000@gatekeeper.tmr.com>
	<3F564EAE.20805@nanovoid.com>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Thu, 04 Sep 2003 01:01:59 +0100
In-Reply-To: <3F564EAE.20805@nanovoid.com> (Blake B.'s message of "Wed, 03
 Sep 2003 14:27:26 -0600")
Message-ID: <6usmndqv48.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Blake B." <shadoi@nanovoid.com> writes:

> Hmm... once I mounted the usbfs, and had the proper modules loaded
> (uhci-usb, etc...) /proc/bus/usb was populated.

"usbdevfs", which is provided by the usbcore module (maybe usb-core)

-- 
Information wants to be left alone.
