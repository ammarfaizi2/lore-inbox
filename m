Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423295AbWJTWne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423295AbWJTWne (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 18:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423297AbWJTWnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 18:43:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3476 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423295AbWJTWnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 18:43:33 -0400
Date: Fri, 20 Oct 2006 15:43:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Gabriel C <nix.or.die@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm2
Message-Id: <20061020154325.78c38ead.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610201403090.29022@twin.jikos.cz>
References: <20061020015641.b4ed72e5.akpm@osdl.org>
	<4538BA2E.9040808@googlemail.com>
	<Pine.LNX.4.64.0610201403090.29022@twin.jikos.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 14:04:09 +0200 (CEST)
Jiri Kosina <jikos@jikos.cz> wrote:

> On Fri, 20 Oct 2006, Gabriel C wrote:
> 
> > I got this on ' make silentoldconfig '
> > drivers/media/dvb/dvb-usb/Kconfig:72:warning: 'select' used by config
> > symbol 'DVB_USB_DIB0700' refer to undefined symbol 'DVB_DIB7000M'
> 
> This is not a new warning, and should already be fixed for some two weeks 
> or so in the v4l-dvb tree.

The -mm tree includes the dvb/v4l tree.  We've all been patiently waiting
for that warning to go away for a few weeks now.

