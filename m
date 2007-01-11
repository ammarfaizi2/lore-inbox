Return-Path: <linux-kernel-owner+w=401wt.eu-S1030335AbXAKNJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbXAKNJJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 08:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbXAKNJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 08:09:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:39130 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030335AbXAKNJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 08:09:07 -0500
From: Oliver Neukum <oneukum@suse.de>
Organization: Novell
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-usb-devel] 2.6.20-rc4: null pointer deref in khubd
Date: Thu, 11 Jan 2007 14:08:53 +0100
User-Agent: KMail/1.9.1
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>,
       linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, kernel list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0701101732160.5563-100000@iolanthe.rowland.org> <200701110853.26871.oneukum@suse.de> <20070111103406.GA5943@elf.ucw.cz>
In-Reply-To: <20070111103406.GA5943@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701111408.54424.oneukum@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 11. Januar 2007 11:34 schrieb Pavel Machek:

[on USB_MULTITHREAD_PROBE]
> Can we delete that config option for 2.6.20? (And sorry for a crappy report).

Somebody already has done so, however he left the module parameter.
I'll remove that, too.

	Regards
		Oliver
