Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292480AbSBPIiT>; Sat, 16 Feb 2002 03:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292447AbSBPIh7>; Sat, 16 Feb 2002 03:37:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53261 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292434AbSBPIhu>;
	Sat, 16 Feb 2002 03:37:50 -0500
Message-ID: <3C6E1A5C.436543E5@mandrakesoft.com>
Date: Sat, 16 Feb 2002 03:37:48 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
In-Reply-To: <20020215135557.B10961@thyrsus.com> <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215213833.J27880@suse.de> <20020215154540.F12540@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> The first thing I heard, from mec two years ago, was "the CML1 code
> base is not salvageable".  This was then and is now the unanimous opinion of
> the kbuild team.  Not just mine; in fact, they concluded it before
> I entered the picture.
> 
> I have seen nothing since to make me change that opinion.

So Alan Cox's opinion counts as nothing?
mconfig counts as nothing?

Anyway, I think you are missing the point.  Sure, CML1 has problems, but
is your solution the one we want for the kernel?  I do not think that is
clear yet.  And bragging about a system's use in production tells us
little about its suitability for most kernel developers, or whether
you've addressed the global dependencies problem, or the syntax problem,
etc.

I'm sure CML2 configurator is whiz-bang, but it needs to do basic stuff
like having "make oldconfig" work exactly like it does in the current
config system.

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
