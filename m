Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263312AbTJUUUN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263313AbTJUUUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:20:13 -0400
Received: from ns.suse.de ([195.135.220.2]:49802 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263312AbTJUUUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:20:10 -0400
Date: Tue, 21 Oct 2003 22:19:58 +0200
From: Olaf Hering <olh@suse.de>
To: =?utf-8?Q?Dani=C3=ABl?= Mantione <daniel@deadlock.et.tudelft.nl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] atyfb updates
Message-ID: <20031021201958.GA11113@suse.de>
References: <Pine.GSO.4.21.0310101754050.8302-100000@waterleaf.sonytel.be> <Pine.LNX.4.44.0310102109560.7665-100000@deadlock.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0310102109560.7665-100000@deadlock.et.tudelft.nl>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Oct 10, Daniël Mantione wrote:

> 
> 
> On Fri, 10 Oct 2003, Geert Uytterhoeven wrote:
> 
> > This one is still needed to get atyfb compiled when Mach64 GX support is
> > enabled.
> 
> Ok, go ahead! We'll also need to get that Mach64 LT fifo width set to 24
> bit and the Powerbook special detection applied.

This patch is still missing, ibook1 doesnt work (unless I missed a patch
to fix it).


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
