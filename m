Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264499AbUEUX6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbUEUX6A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265252AbUEUXvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:51:55 -0400
Received: from zeus.kernel.org ([204.152.189.113]:8380 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265108AbUEUXaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:30:23 -0400
Date: Wed, 19 May 2004 16:48:22 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Tim Bird <tim.bird@am.sony.com>
cc: Adrian Bunk <bunk@fs.tum.de>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: CE Linux Forum - Specification V1.0 draft
In-Reply-To: <40ABC5AF.6070109@am.sony.com>
Message-ID: <Pine.LNX.4.44.0405191644550.15495-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2004, Tim Bird wrote:

> Verifying that something is supported correctly on multiple
> architectures is not simple.  Yes, we know that the default
> optimization level for ARM is -Os.  As recently as last month,
> there was a problem report about -Os on the gcc mailing list.

Incidentally, with all gcc-3.* in existence today, the kernel gets
miscompiled if -Os is not used on ARM due to a gcc bug.  But this is not the
reason why -Os was chosen as default on ARM though.


Nicolas

