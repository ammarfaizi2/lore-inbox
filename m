Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316079AbSFEUGk>; Wed, 5 Jun 2002 16:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316167AbSFEUGj>; Wed, 5 Jun 2002 16:06:39 -0400
Received: from ms1.adiis.net ([207.177.36.3]:58769 "EHLO ms1.adiis.net")
	by vger.kernel.org with ESMTP id <S316079AbSFEUGi>;
	Wed, 5 Jun 2002 16:06:38 -0400
Subject: Re: Linux based VOIP PBX?
From: Ryan Butler <rbutler@adiis.net>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200206051927.g55JRQT10007@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 05 Jun 2002 15:06:34 -0500
Message-Id: <1023307595.25283.36.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-05 at 14:27, Larry McVoy wrote:
> Hi, sorry for the somewhat off topic question, but I'd love to know if there
> are any production quality Linux based voice over IP products out there.
> We currently use a 3com NBX and it sort of sucks.  It works fine on a
> LAN, it sucks on a WAN.  I'm open to replacing it, but if I did, I'd want
> to go with a Linux based system, for lots of reasons.  If you know of such
> a product, or are working on one, please contact me.  I don't want a free
> product, I want to pay for it and I want it to work.  100% of the time.
> And we need the voicemail/conferencing/menutree stuf that you get with 
> a real product.
> 
> We have $15K into the 3com, so that gives you some idea of our willingness
> to spend money.
> -

Hey Larry,

You might check out the asterisk project, http://www.asteriskpbx.org
Its a fully open source pc based PBX system that supports a wide variety
of PSTN options as well as a open source voip protocol called IAX, as
well as H.323 and SIP support is supposed to be coming (as soon as a
group or a person wants to donate some cash to its implementation).  So
far I have been very impressed with their progress.

Ryan Butler
rbutler@adiis.net


