Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264612AbSJWK3R>; Wed, 23 Oct 2002 06:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264615AbSJWK3R>; Wed, 23 Oct 2002 06:29:17 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:40386 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S264612AbSJWK3Q>;
	Wed, 23 Oct 2002 06:29:16 -0400
Date: Wed, 23 Oct 2002 12:35:19 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.5 Problem Report Status
Message-ID: <20021023123519.A28983@ucw.cz>
References: <Pine.LNX.4.44.0210222038380.8594-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0210222038380.8594-100000@dad.molina>; from tmolina@cox.net on Tue, Oct 22, 2002 at 09:07:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 09:07:13PM -0500, Thomas Molina wrote:

> Following is the latest version of my status report web page.  It can be 
> found at:
> 
> http://members.cox.net/tmolina/kernprobs/status.html
> 
> I've seen a lot of positive feedback for Martin's proposal to create a 
> bugzilla for kernel bug reports so this is likely to be my last formal 
> posting on this subject.  I intend to enter these as the "seed" bug 
> reports for his effort, so any comment on this is welcome.  

> --------------------------------------------------------------------------
>    open                   06 Oct 2002 analog joystick oops
>   33. http://marc.theaimsgroup.com/?l=linux-kernel&m=103393598801189&w=2

Closed, fixed by properly calling init_input_dev() in analog.c

> --------------------------------------------------------------------------
>    open                   10 Oct 2002 keyboard generates bogus key results
>   35. http://marc.theaimsgroup.com/?l=linux-kernel&m=103423327423623&w=2

Closed, PS/2 Active Multiplexing support was fixed.


-- 
Vojtech Pavlik
SuSE Labs
