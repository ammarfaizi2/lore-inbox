Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276648AbRJQNgJ>; Wed, 17 Oct 2001 09:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276642AbRJQNgA>; Wed, 17 Oct 2001 09:36:00 -0400
Received: from sushi.toad.net ([162.33.130.105]:20636 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S276648AbRJQNfx>;
	Wed, 17 Oct 2001 09:35:53 -0400
Subject: Re: [PATCH] PnP BIOS -- bugfix; update devlist on setpnp
From: Thomas Hood <jdthood@mail.com>
To: "Steven A. DuChene" <sduchene@mindspring.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011017041014.B2015@lapsony.mydomain.here>
In-Reply-To: <1003288485.14282.100.camel@thanatos> 
	<20011017041014.B2015@lapsony.mydomain.here>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 17 Oct 2001 09:35:34 -0400
Message-Id: <1003325742.12542.164.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-10-17 at 04:10, Steven A. DuChene wrote:
> OK, I tried this with the Intel STL2 motherboard I also have and I got
> a similar error when trying to load the correct i2c bus module when the
> PnPBIOS stuff is compiled into the kernel.

Understood.

I'd just like to reiterate that my patch isn't the cause
of your problem.  It's just that my patch doesn't address
your problem.  IIUC.

I provided a "workaround patch" before.  Can you continue
to use that for the time being?

I'd like to make a promise that I'll submit a new patch
soon that will address your problem; however I don't yet know
exactly how to go about addressing it.

--
Thomas

