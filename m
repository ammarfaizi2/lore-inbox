Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbVBBP6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbVBBP6b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 10:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVBBP6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 10:58:30 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:46306 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262600AbVBBP5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 10:57:34 -0500
Date: Wed, 2 Feb 2005 16:57:43 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Pete Zaitcev <zaitcev@redhat.com>, Peter Osterlund <petero2@telia.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Touchpad problems with 2.6.11-rc2
Message-ID: <20050202155743.GA3351@ucw.cz>
References: <20050123190109.3d082021@localhost.localdomain> <m3acqr895h.fsf@telia.com> <20050201234148.4d5eac55@localhost.localdomain> <20050202102033.GA2420@ucw.cz> <d120d5000502020751db00e48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000502020751db00e48@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 10:51:38AM -0500, Dmitry Torokhov wrote:

> I wonder if we should just add speed factor (along with tap distance)
> options to mousedev. Vojtech, will you take such patch? I know you
> want to drop mousedev and have everyone use evdev but, although people
> started switching, it will not happen until distributions (or
> XOrg/XFree themselves) have these drivers available straight out of
> the box.
 
I would be OK with that if we take the default from the touchpad
resolution, so that the driver uses a reasonable value without having to
use the speed parameter.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
