Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932602AbWJLPPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbWJLPPP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbWJLPPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:15:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19688 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932602AbWJLPPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:15:13 -0400
Date: Thu, 12 Oct 2006 08:13:06 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: linux-usb-devel@lists.sourceforge.net, Pavel Machek <pavel@suse.cz>,
       gregkh@suse.de, Paolo Abeni <paolo.abeni@email.it>,
       linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: [PATCH] usbmon: add binary interface
Message-Id: <20061012081306.8aa94f61.zaitcev@redhat.com>
In-Reply-To: <200610121017.52655.duncan.sands@math.u-psud.fr>
References: <1160557065.9547.12.camel@localhost.localdomain>
	<20061011194443.GA3935@ucw.cz>
	<20061011134351.0c79445a.zaitcev@redhat.com>
	<200610121017.52655.duncan.sands@math.u-psud.fr>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 10:17:52 +0200, Duncan Sands <duncan.sands@math.u-psud.fr> wrote:

> By the way, any reason why CONFIG_USB_MON doesn't select CONFIG_DEBUG_FS?
> Is usbmon useful without debugfs?

It's not now, but it will be once I and Paolo are done here.

-- Pete
