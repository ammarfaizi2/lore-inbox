Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbTAUK7G>; Tue, 21 Jan 2003 05:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266981AbTAUK7G>; Tue, 21 Jan 2003 05:59:06 -0500
Received: from hera.cwi.nl ([192.16.191.8]:59592 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S266977AbTAUK7F>;
	Tue, 21 Jan 2003 05:59:05 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 21 Jan 2003 12:08:10 +0100 (MET)
Message-Id: <UTC200301211108.h0LB8Ad12683.aeb@smtp.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, jim.houston@attbi.com
Subject: Re: [patch] IDE OnTrack remap for 2.5.58
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    On Thu, 2003-01-16 at 18:14, Jim Houston wrote:
    > I went back and looked through the patches and found that the remapping
    > support was removed in patch-2.5.30.  The comments in the mailing list
    > suggest that it belonged in user space.

[of course a shift cannot be done in user space]

    > I have not found code/instructions on how to do this.
    > Since then, most of IDE code has been reverted to the
    > 2.4 versions but not this bit.

    This was done without the involvement of the IDE maintainers.
    Please direct complaints to Andries Brouwer. Come 2.6 the vendors
    will all be merging it back into their trees.

    Alan

Ha, Alan -

I think both Andre and Martin were happy, but maybe you mean nobody
asked you? Are you unhappy with this change? And if so, why?

Andries
