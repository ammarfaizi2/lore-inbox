Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTL2RdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 12:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbTL2RdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 12:33:15 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:25984 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S263850AbTL2RdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 12:33:07 -0500
Date: Mon, 29 Dec 2003 18:33:02 +0100
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't mount USB partition as root
Message-ID: <20031229183302.B32137@beton.cybernet.src>
References: <20031229173853.A32038@beton.cybernet.src> <Pine.LNX.4.58.0312300045070.24938@silk.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0312300045070.24938@silk.corp.fedex.com>; from jeffchua@silk.corp.fedex.com on Tue, Dec 30, 2003 at 12:47:06AM +0800
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 12:47:06AM +0800, Jeff Chua wrote:
> 
> You'll need to load the usb modules using initrd ramdisk, then switch root
> to the usb device to continue booting the system.

This is the problem #2. I am not able to remount /. "device or resource busy".
How do I remount the "/"?

Cl<
