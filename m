Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289930AbSAWRt3>; Wed, 23 Jan 2002 12:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289937AbSAWRtT>; Wed, 23 Jan 2002 12:49:19 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:49039 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S289930AbSAWRtM>; Wed, 23 Jan 2002 12:49:12 -0500
Date: Wed, 23 Jan 2002 10:49:01 -0700
Message-Id: <200201231749.g0NHn1h31634@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Antti Salmela <asalmela@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.4.17, SMP, AMD, devfs, highmem.
In-Reply-To: <20020123152406.A4992@wasala.fi>
In-Reply-To: <20020123152406.A4992@wasala.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antti Salmela writes:
> Kernel compiled with gcc version 2.95.4 (Debian prerelease).
> 
> If any additional information is required, please ask.

If you had searched the list archives, you would have seen that this
bug has already been fixed. Even if you're too lazy to do that, you
should at least apply the latest pre-patch (2.4.18-pre6 as I write
this) and see if the problem goes away. That's standard procedure:
always try to reproduce an Oops using the latest kernel. 2.4.17 is
over a month old: a lot has happened since then.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
