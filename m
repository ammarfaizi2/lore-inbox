Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289366AbSBNCEB>; Wed, 13 Feb 2002 21:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289365AbSBNCDv>; Wed, 13 Feb 2002 21:03:51 -0500
Received: from dsl-213-023-039-092.arcor-ip.net ([213.23.39.92]:7055 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289353AbSBNCDi>;
	Wed, 13 Feb 2002 21:03:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mike Fedyk <mfedyk@matchmail.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
Date: Thu, 14 Feb 2002 03:07:50 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.3.96.1020213170030.12448F-100000@gatekeeper.tmr.com> <E16bA59-0002Qa-00@starship.berlin> <20020214015947.GD335@matchmail.com>
In-Reply-To: <20020214015947.GD335@matchmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16bBJO-0002Rh-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 14, 2002 02:59 am, Mike Fedyk wrote:
> On Thu, Feb 14, 2002 at 01:49:03AM +0100, Daniel Phillips wrote:
> > Dangerous advocacy of the broken SuS semantics for sync, has to be stamped
> > out before it spreads ;-)
> 
> Daniel,
> 
> You seem to be taking both sides of this argument.
> 
> Do you agree that sync should be changed to a checkpoint so that doesn't
> block for dirty data created *after* sync was called?

Yes, sorry if I was ambiguous in stating that in any way.

-- 
Daniel
