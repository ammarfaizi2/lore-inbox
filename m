Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVBMTMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVBMTMa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 14:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVBMTM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 14:12:29 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:42895 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261293AbVBMTM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 14:12:27 -0500
Date: Sun, 13 Feb 2005 20:13:01 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stephen Evanchik <evanchsa@gmail.com>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Message-ID: <20050213191301.GA4286@ucw.cz>
References: <a71293c20502031443764fb4e5@mail.gmail.com> <20050205104405.GA1401@elf.ucw.cz> <20050207101417.GB16443@ucw.cz> <a71293c205021311071a7cf4d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71293c205021311071a7cf4d7@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2005 at 02:07:39PM -0500, Stephen Evanchik wrote:

> > > Perhaps this should be done in userspace? It is probably usable on
> > > non-trackpoint devices, too...
> > 
> > For a big part it's not possible to do in userspace, because the
> > touchpoint doesn't give the pressure information, it only can be mapped
> > to a button click.
> > 
> > But middle-button-to-scroll would be doable in userspace, yes.
> 
> Middle-to-scroll in the newer Xorg releases. I received a number of
> requests from users to include this feature, I'm not sure why the Xorg
> option is inadequate. It can be removed if necessary.
 
I'm glad it's in the Xorg X server. It's the right place for it to be.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
