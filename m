Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282489AbRKZU1V>; Mon, 26 Nov 2001 15:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282479AbRKZU1C>; Mon, 26 Nov 2001 15:27:02 -0500
Received: from zero.tech9.net ([209.61.188.187]:15369 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282489AbRKZU0v>;
	Mon, 26 Nov 2001 15:26:51 -0500
Subject: Re: Mixing Patches: pre-emptive + xfs
From: Robert Love <rml@tech9.net>
To: "Elgar, Jeremy" <JElgar@ndsuk.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F128989C2E99D4119C110002A507409801C53035@topper.hrow.ndsuk.com>
In-Reply-To: <F128989C2E99D4119C110002A507409801C53035@topper.hrow.ndsuk.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 26 Nov 2001 15:26:48 -0500
Message-Id: <1006806412.992.8.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-26 at 06:13, Elgar, Jeremy wrote:
> Just wondering if anyone has try using these two patches together (or is
> this a really bad idea)
> 
> I'm thinking of adding the pre-emptive patch to my laptop and desk top.

Although I haven't done any formal testing on XFS, I have heard XFS and
preempt-kernel work fine together from a couple of users.

The only problem reported was a compile error, which Keith Owens merged
a fix for.  If you do have problems, report them and perhaps we can
help.

	Robert Love

