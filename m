Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261532AbSJILRJ>; Wed, 9 Oct 2002 07:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261534AbSJILRI>; Wed, 9 Oct 2002 07:17:08 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:34176 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261532AbSJILRF>;
	Wed, 9 Oct 2002 07:17:05 -0400
Date: Wed, 9 Oct 2002 13:22:23 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Arnaud Gomes-do-Vale <arnaud@carrosse.frmug.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No mouse wheel in 2.5.40
Message-ID: <20021009132223.B714@ucw.cz>
References: <m3fzvpr833.fsf@carrosse.in.glou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3fzvpr833.fsf@carrosse.in.glou.org>; from arnaud@carrosse.frmug.org on Wed, Oct 02, 2002 at 02:35:28AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 02:35:28AM +0200, Arnaud Gomes-do-Vale wrote:

> I have just tried 2.5.40, my mouse wheel doesn't work anymore. It
> still works as a third button, bot not as a wheel. It works OK with
> 2.4.20-pre7 with the same configuration. The mouse is a Logitech OEM
> PS/2 wheel mouse (with black logo). Here is the input device section
> from my .config:

What does 'dmesg' report? What do you use in X/gpm as mouse type?

-- 
Vojtech Pavlik
SuSE Labs
