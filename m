Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVARRrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVARRrE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 12:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVARRrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 12:47:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:53674 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261356AbVARRrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 12:47:01 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Patch to control VGA bus routing and active VGA device.
Date: Tue, 18 Jan 2005 09:46:46 -0800
User-Agent: KMail/1.7.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Egbert Eich <eich@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9e47339105011719436a9e5038@mail.gmail.com>
In-Reply-To: <9e47339105011719436a9e5038@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501180946.47026.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 17, 2005 7:43 pm, Jon Smirl wrote:
> Attached is a patch to control VGA bus routing and the active VGA
> device. It works by adding sysfs attributes to bridge and VGA devices.
> The bridge attribute is read only and indicates if the bridge is
> routing VGA. The attribute on the device has four values:

How is it supposed to work?  Is VGA routing determined by the chipset?  Is it 
separate from other legacy I/O and memory addresses?

Thanks,
Jesse

P.S. Can you fix your mailer to set a mimetype other than "unspecified binary 
data" for patches to make them easier to read?
