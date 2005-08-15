Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbVHOVFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbVHOVFa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbVHOVFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:05:30 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:36954 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964964AbVHOVFa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:05:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q+VcE2tVE14iLsYW9jKJZGAfF8/uO8HAmAWZ+c5vdDA+/ux2HXA2NXMxUF3Q8B0J2A556uRiZ/hdKaUfN1Q0PIU528qpuLV/AkDiw+6o6XRAIU1gSY3XrcOuwCk28Nh7tjx4g6K86N4JDMZDsYue3MwD3nDW0hX3QluBC7cY0/Q=
Message-ID: <9e473391050815140566386e3a@mail.gmail.com>
Date: Mon, 15 Aug 2005 17:05:27 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: Joe Peterson <joe@skyrush.com>
Subject: Re: [PATCH] to drivers/input/evdev.c to add mixer device "/dev/input/events"
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <9e47339105081513245b168d24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4300D09C.4030702@skyrush.com> <20050815174558.GB1450@ucw.cz>
	 <4300D845.8070605@skyrush.com> <20050815185729.GA1450@ucw.cz>
	 <4300EF7C.9020500@skyrush.com>
	 <9e47339105081513245b168d24@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/05, Jon Smirl <jonsmirl@gmail.com> wrote:
> The xorg evdev input driver is here:
> http://cvs.freedesktop.org/xorg/driver/xf86-input-evdev/

I see it is not there yet. Here is the old one:
http://cvs.freedesktop.org/xorg/xc/programs/Xserver/hw/xfree86/input/evdev/

> 
> --
> Jon Smirl
> jonsmirl@gmail.com
> 


-- 
Jon Smirl
jonsmirl@gmail.com
