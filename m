Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267367AbTAGKfj>; Tue, 7 Jan 2003 05:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267366AbTAGKfi>; Tue, 7 Jan 2003 05:35:38 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:27798 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267367AbTAGKfi>;
	Tue, 7 Jan 2003 05:35:38 -0500
Date: Tue, 7 Jan 2003 11:44:03 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: include order for i2c-amd8111
Message-ID: <20030107114403.A5029@ucw.cz>
References: <20030105231349.GA8714@elf.ucw.cz> <20030106004057.127332C0AA@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030106004057.127332C0AA@lists.samba.org>; from rusty@rustcorp.com.au on Mon, Jan 06, 2003 at 11:40:20AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 11:40:20AM +1100, Rusty Russell wrote:

> In message <20030105231349.GA8714@elf.ucw.cz> you write:
> > Hi!
> > 
> > It seems all linux then all asm is prefered order...
> > 								Pavel
> 
> Yes, but not for any great reason, AFAICT.  I think this comes under
> the "too trivial" rule (ie.  I'll accept it from the author, but not
> someone else).

The author (me ;) definitely doesn't mind you applying the patch, but
would prefer if the one who pushed the 8111 driver into the kernel
(Pavel) would update it to the version found in lm_sensors 2.7.0 at the
same time.

Thanks.

-- 
Vojtech Pavlik
SuSE Labs
