Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbUCaJWA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 04:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbUCaJWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 04:22:00 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:24071 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261874AbUCaJV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 04:21:59 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: wolk-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] speedtouch and/or USB problem (2.6.4-WOLK2.3)
Date: Wed, 31 Mar 2004 11:21:27 +0200
User-Agent: KMail/1.6.1
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Grzegorz Kulewski <kangur@polcom.net>,
       lkml <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>, <speedtouch@ml.free.fr>
References: <Pine.LNX.4.44L0.0403271851040.2209-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0403271851040.2209-100000@ida.rowland.org>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403311121.27731@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 March 2004 00:51, Alan Stern wrote:

Hi Grzegorz,

> > When running modem_run on 2.6.4-WOLK2.3 it locks in D state on one of USB
> > ioctls. It works at least on 2.6.2-rc2. I have no idea what causes this
> > bug so I sent it to all lists.
> > Please help if you can.
> > Grzegorz Kulewski

> Try applying this patch:
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108016447231291&q=raw

Did this help Grzegorz?

ciao, Marc
