Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTKRN4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbTKRNxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:53:55 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:33989 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263532AbTKRNw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:52:58 -0500
Date: Tue, 18 Nov 2003 14:52:45 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, dtor_core@ameritech.net
Subject: Re: [PATCH] PS/2 mouse rate setting
Message-ID: <20031118135245.GA32442@ucw.cz>
References: <20031027140217.GA1065@averell.suse.lists.linux.kernel> <20031028035625.GB20145@rivenstone.net.suse.lists.linux.kernel> <20031028094709.GA4325@ucw.cz.suse.lists.linux.kernel> <200310290136.06439.dtor_core@ameritech.net.suse.lists.linux.kernel> <20031029083040.GA18135@ucw.cz.suse.lists.linux.kernel> <p73y8v48b3u.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73y8v48b3u.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 01:47:01PM +0100, Andi Kleen wrote:
> Vojtech Pavlik <vojtech@suse.cz> writes:
> > 
> > Thanks!
> 
> Actually partly being guilty of it too - but as Andries points out it would
> make much more sense to convert this stuff to sysctls. There is no
> reason at all why you should need to reboot the box just to change the 
> settings of the mouse.
> 
> [In fact requiring a reboot is very "Windows"-like]
> 
> If there is a possibility for merging this I can do a patch ...

Sysfs would be much better.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
