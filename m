Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbTLJRZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTLJRZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:25:56 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:65476 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263805AbTLJRZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:25:55 -0500
Message-ID: <3FD7591A.8020100@pacbell.net>
Date: Wed, 10 Dec 2003 09:34:18 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Duncan Sands <baldrick@free.fr>
CC: linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
References: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org> <200312101422.40088.baldrick@free.fr> <200312101720.22731.oliver@neukum.org> <200312101749.17173.baldrick@free.fr>
In-Reply-To: <200312101749.17173.baldrick@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Unfortunately, usb_physical_reset_device calls usb_set_configuration
> which takes dev->serialize.

Not since late August it doesn't ...


