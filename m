Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290747AbSARQtV>; Fri, 18 Jan 2002 11:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290739AbSARQtP>; Fri, 18 Jan 2002 11:49:15 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:53771 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290749AbSARQsB>;
	Fri, 18 Jan 2002 11:48:01 -0500
Date: Sat, 12 Jan 2002 05:31:51 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Eric S. Raymond" <esr@thyrsus.com>, Doug McNaught <doug@wireboard.com>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        linux-kernel@vger.kernel.org, greg@kroah.com, felix-dietlibc@fefe.de
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020112053150.A511@toy.ucw.cz>
In-Reply-To: <200201092005.g09K5OL28043@snark.thyrsus.com> <m3n0zn6ysr.fsf@varsoon.denali.to> <20020109154425.A28755@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020109154425.A28755@thyrsus.com>; from esr@thyrsus.com on Wed, Jan 09, 2002 at 03:44:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> You're right, I don't need this to be done at kernel level.  I do need it to
> be done *everywhere*.  I'm not sure how else to guarantee this will happen. 

Ehm? autoconfig is not good enough reason to force *everyone* to do dmi
scanning. I don't give a damn about autoconfig, and you are not going
to force it to my machines. Stop trying.

It may be reasonable if you wanted major distros to have that. Just don't
say *everyone*.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

