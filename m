Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280195AbRKEEGN>; Sun, 4 Nov 2001 23:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280192AbRKEEGD>; Sun, 4 Nov 2001 23:06:03 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:62883 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280200AbRKEEFx>;
	Sun, 4 Nov 2001 23:05:53 -0500
Date: Sun, 4 Nov 2001 23:05:52 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Stuart Young <sgy@amc.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <5.1.0.14.0.20011105144855.01f83310@mail.amc.localnet>
Message-ID: <Pine.GSO.4.21.0111042304270.23204-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Nov 2001, Stuart Young wrote:

> Any reason we can't move all the process info into something like 
> /proc/pid/* instead of in the root /proc tree?

Thanks, but no thanks.  If we are starting to move stuff around, we
would be much better off leaving in /proc only what it was supposed
to contain - per-process information.

