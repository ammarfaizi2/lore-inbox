Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWDVVxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWDVVxl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 17:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWDVVxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 17:53:41 -0400
Received: from styx.suse.cz ([82.119.242.94]:49868 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751125AbWDVVxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 17:53:40 -0400
Date: Sat, 22 Apr 2006 23:53:56 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: linux-kernel@vger.kernel.org, dtor_core@ameritech.net
Subject: Re: usbkbd not reporting unknown keys
Message-ID: <20060422215356.GA11798@suse.cz>
References: <d120d5000603081247i69f9e7dbm6ef614f50140227f@mail.gmail.com> <305c16960603081334k25ce9a89g132876d4c9246fc6@mail.gmail.com> <d120d5000603090543p3446b4a0sddaaa031ad2513ca@mail.gmail.com> <305c16960603091230r32038a86mbefc6d80bedb24ab@mail.gmail.com> <305c16960603141510g72def22bmd0043d5f71d9ef6@mail.gmail.com> <305c16960604221111u714bd3b1h2aeb0559b07d911b@mail.gmail.com> <20060422185402.GC10613@suse.cz> <305c16960604221259g4ddabca2o6333f7ffcaff8e4f@mail.gmail.com> <20060422200455.GA10994@suse.cz> <305c16960604221401k4e6493b6xa9c898a92c6b028d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305c16960604221401k4e6493b6xa9c898a92c6b028d@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2006 at 06:01:27PM -0300, Matheus Izvekov wrote:

> On 4/22/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > Just point me to the HID debug logs. (I need DEBUG enabled in both
> > hid-core.c and hid-input.c.) Make sure you're running an uptodate
> > kernel. I'll see what is needed to fix the mappings for that keyboard.
> >
> > > Maybe the thread subject should be changed to something more
> > > apropriate, do so if it pleases you.
> 
> Here it is, hope i got everything right.

It seems to be missing something at the top, also the whitespace
formatting seems to be discarded - everything is aligned to the first
column, making it rather hard to read. Please retry using 'dmesg -s 131072'.

-- 
Vojtech Pavlik
Director SuSE Labs
