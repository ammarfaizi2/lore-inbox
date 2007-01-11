Return-Path: <linux-kernel-owner+w=401wt.eu-S1750878AbXAKQvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbXAKQvp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 11:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbXAKQvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 11:51:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:59941 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbXAKQvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 11:51:44 -0500
Date: Thu, 11 Jan 2007 08:51:17 -0800
From: Greg KH <greg@kroah.com>
To: Anssi Hannula <anssi.hannula@gmail.com>, jkosina@suse.cz
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-usb-devel@lists.sourceforge.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] hid: series of patches for PantherLord USB/PS2 2in1 Adapter support
Message-ID: <20070111165117.GA27676@kroah.com>
References: <20070111145115.405679742@delta.onse.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070111145115.405679742@delta.onse.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 04:51:15PM +0200, Anssi Hannula wrote:
> These three patches fix PantherLord USB/PS2 2in1 Adapter support
> so that it appears as two input devices, and add force feedback
> support for it.

HID has a real maintainer now (Jiri Kosina <jkosina@suse.cz>), I suggest
copying him on patches like this for the code.

thanks,

greg k-h
