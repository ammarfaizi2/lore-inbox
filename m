Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVBBRHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVBBRHR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 12:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbVBBRHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 12:07:17 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:58029 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262517AbVBBRHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 12:07:11 -0500
Date: Wed, 2 Feb 2005 18:07:27 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: Re: Touchpad problems with 2.6.11-rc2
Message-ID: <20050202170727.GA2731@ucw.cz>
References: <20050123190109.3d082021@localhost.localdomain> <m3acqr895h.fsf@telia.com> <20050201234148.4d5eac55@localhost.localdomain> <20050202102033.GA2420@ucw.cz> <20050202085628.49f809a0@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202085628.49f809a0@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 08:56:28AM -0800, Pete Zaitcev wrote:
> On Wed, 2 Feb 2005 11:20:33 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> > Well, you removed the scaling to the touchpad resolution, which will
> > cause ALPS touchpad to be significantly slower than Synaptics touchpads.
> > Similarly, the screen size used to be taken into account, but probably
> > that was a mistake, since the value is usually left at default and
> > doesn't correspond to the real screen size.
> 
> Exactly. And it works much better now.
 
With a Synaptics I suppose? You wouldn't like it with an ALPS.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
