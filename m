Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262511AbSJETwi>; Sat, 5 Oct 2002 15:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262525AbSJETwi>; Sat, 5 Oct 2002 15:52:38 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:13285 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262511AbSJETwe>;
	Sat, 5 Oct 2002 15:52:34 -0400
Date: Sat, 5 Oct 2002 21:58:03 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dennis Bj?rklund <db@zigo.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: input layer - activate keyboard
Message-ID: <20021005215803.A54063@ucw.cz>
References: <Pine.LNX.4.44.0210020734480.10497-100000@zigo.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0210020734480.10497-100000@zigo.dhs.org>; from db@zigo.dhs.org on Wed, Oct 02, 2002 at 07:48:16AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 07:48:16AM +0200, Dennis Bj?rklund wrote:
> I see there is a lot of talk about a new input layer so why not some 
> more!
> 
> I have an IBM Rapid Access keyboard that needs to be sent an activation
> code to activate the multimedia keys at startup. Is there support for
> this? I would not be surprised if there where other input devices who also
> needs commands sent to them.
> 
> I am very used to this keyboard and I wouldn't want to exchange it, so
> even though I have not yet tried 2.5.x I'll probably do it just for this.

Yes, the new input code sends this activation, detects the keyboard and
enables the extra keys and LED.

-- 
Vojtech Pavlik
SuSE Labs
