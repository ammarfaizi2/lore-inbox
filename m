Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265367AbUAJT5X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265366AbUAJT5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:57:22 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:28585 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265367AbUAJT4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:56:53 -0500
Date: Sat, 10 Jan 2004 20:56:39 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Do not use synaptics extensions by default
Message-ID: <20040110195639.GE22654@ucw.cz>
References: <20040110175930.GA1749@elf.ucw.cz> <200401101428.49358.dtor_core@ameritech.net> <20040110195124.GC1212@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040110195124.GC1212@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 08:51:24PM +0100, Pavel Machek wrote:
> Hi!
> 
> > Why would you document something that is deprecated? It was removed so the
> > new users would not start using it instead of psmouse.proto. psmouse.noext
> > should be gone soon.
> 
> My understanding is that Documentation/kernel-parameters.txt should
> document all available parameters...

Well, I wouldn't mind documenting psmouse.noext, with a comment that it
shouldn't be used because it'll be removed in near future.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
