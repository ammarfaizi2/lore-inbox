Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbUKAJkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbUKAJkn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 04:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbUKAJkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 04:40:43 -0500
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:14208 "EHLO
	midnight.suse.cz") by vger.kernel.org with ESMTP id S261764AbUKAJiq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 04:38:46 -0500
Date: Mon, 1 Nov 2004 10:38:31 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: Map extra keys on compaq evo
Message-ID: <20041101093830.GA1145@ucw.cz>
References: <20041031213859.GA6742@elf.ucw.cz> <200410312016.08468.dtor_core@ameritech.net> <20041101080306.GA1002@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101080306.GA1002@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 09:03:07AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > Compaq Evo notebooks seem to use non-standard keycodes for their extra
> > > keys. I workaround that quirk with dmi hook.
> > > 
> > 
> > Why don't you just call "setkeycodes" from your init script?
> 
> In such case I'd need to configure keys at two different places, and
> that's ugly. I have to configure these extra keys with "hotkeys"
> anyway (input layer does not provide list of keys available, so

It does.

> "hotkeys" . Having to configure this at two places is pretty ugly.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
