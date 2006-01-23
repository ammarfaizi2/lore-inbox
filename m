Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWAWVun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWAWVun (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWAWVun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:50:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52398 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932186AbWAWVum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:50:42 -0500
Date: Mon, 23 Jan 2006 13:50:18 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <gregkh@suse.de>
Cc: david-b@pacbell.net, ak@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: EHCI + APIC errors = no usb goodness
Message-Id: <20060123135018.4d074a73.zaitcev@redhat.com>
In-Reply-To: <20060123214115.GA15338@suse.de>
References: <20060123210443.GA20944@suse.de>
	<20060123132554.13411a1d.zaitcev@redhat.com>
	<20060123214115.GA15338@suse.de>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006 13:41:15 -0800, Greg KH <gregkh@suse.de> wrote:

> Hm, it's a brand-new laptop [...]
> oh, and 2.6.13 seems to work just fine, with ioapic enabled...

Sorry, I didn't catch that. You wrote "a real old 2.6 kernel worked" and
I thought you hark back to 2.6.5 or something. Never mind then.

Oh and by the way, the traceback you posted was 32-bit.

-- Pete
