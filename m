Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbTAUG7g>; Tue, 21 Jan 2003 01:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265800AbTAUG7g>; Tue, 21 Jan 2003 01:59:36 -0500
Received: from dhcp34.trinity.linux.conf.au ([130.95.169.34]:14976 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S265670AbTAUG7f>; Tue, 21 Jan 2003 01:59:35 -0500
Subject: Re: [patch] IDE OnTrack remap for 2.5.58
From: Alan <alan@lxorguk.ukuu.org.uk>
To: jim.houston@attbi.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200301161814.h0GIEbb02258@linux.local>
References: <200301161814.h0GIEbb02258@linux.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043051077.12165.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 20 Jan 2003 08:25:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-16 at 18:14, Jim Houston wrote:
> I went back and looked through the patches and found that the remapping
> support was removed in patch-2.5.30.  The comments in the mailing list
> suggest that it belonged in user space.  I have not found code/instructions
> on how to do this.  Since then, most of IDE code has been reverted to the
> 2.4 versions but not this bit.

This was done without the involvement of the IDE maintainers. Please direct
complaints to Andries Brouwer. Come 2.6 the vendors will all be merging
it back into their trees.

Alan

