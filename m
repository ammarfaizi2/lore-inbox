Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbUAJTuE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbUAJTuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:50:04 -0500
Received: from gprs214-70.eurotel.cz ([160.218.214.70]:8832 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265213AbUAJTuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:50:01 -0500
Date: Sat, 10 Jan 2004 20:51:24 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, vojtech@suse.cz
Subject: Re: Do not use synaptics extensions by default
Message-ID: <20040110195124.GC1212@elf.ucw.cz>
References: <20040110175930.GA1749@elf.ucw.cz> <200401101428.49358.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401101428.49358.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Why would you document something that is deprecated? It was removed so the
> new users would not start using it instead of psmouse.proto. psmouse.noext
> should be gone soon.

My understanding is that Documentation/kernel-parameters.txt should
document all available parameters...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
