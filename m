Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285229AbSBRU6c>; Mon, 18 Feb 2002 15:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286179AbSBRU6X>; Mon, 18 Feb 2002 15:58:23 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10245 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S285424AbSBRU6N>; Mon, 18 Feb 2002 15:58:13 -0500
Date: Mon, 18 Feb 2002 21:58:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-pre9-mjc2
Message-ID: <20020218205806.GD14521@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020217134529.A36@toy.ucw.cz> <E16ct5j-0006O3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16ct5j-0006O3-00@the-village.bc.nu>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Be very careful merging lm_sensors. Incorrect use of it is a wonderful
> > > way to do things like totally destroy (back to factory) an ibm thinkpad.
> > > Thats why I've always stayed clear of it
> > 
> > They deserve it! Shipping hardware that commits suicide on i2c access is 
> > bad thing (tm).
> 
> IBM don't replace machines where you do that. So I suspect you'll have a few
> users with very different views on the matter.

Someone should buy thinkpad, destroy it (preferably with CD labeled
Virus 98 or soemthing like that), return, destroy next, return,
destroy next, request money back.

Alternatively make a virus that destroys thinkpads -- should make them
some bad press, too.
									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
