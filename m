Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129620AbRBFPgK>; Tue, 6 Feb 2001 10:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129318AbRBFPfv>; Tue, 6 Feb 2001 10:35:51 -0500
Received: from ns.sysgo.de ([213.68.67.98]:40439 "EHLO rob.devdep.sysgo.de")
	by vger.kernel.org with ESMTP id <S129172AbRBFPfs>;
	Tue, 6 Feb 2001 10:35:48 -0500
From: Robert Kaiser <rob@sysgo.de>
Reply-To: rob@sysgo.de
To: Hacksaw <hacksaw@hacksaw.org>
Subject: Re: Disk is cheap?
Date: Tue, 6 Feb 2001 16:30:12 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <200102061528.f16FSir15100@habitrail.home.fools-errant.com>
In-Reply-To: <200102061528.f16FSir15100@habitrail.home.fools-errant.com>
Cc: Pavel Machek <pavel@suse.cz>, Patrizio Bruno <patrizio@dada.it>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01020616352700.04185@rob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 06 Feb 2001 you wrote:
> But paring down the startup scripts is a good idea. For something like an embedded 
> device, you might even want to go with a custom init, 

Yes, I'm using busybox (see busybox.lineo.com). It's a multi-call binary that
contains a simplified init, a shell and a host of other nice things.

> that just runs your main program.

Well the _very_ minimal approach is to have your main program _be_ init :-)



----------------------------------------------------------------
Robert Kaiser                         email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14                    phone: (49) 6136 9948-762
D-55270 Klein-Winternheim / Germany   fax:   (49) 6136 9948-10
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
