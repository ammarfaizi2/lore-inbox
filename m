Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132737AbRDQQPN>; Tue, 17 Apr 2001 12:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132743AbRDQQPD>; Tue, 17 Apr 2001 12:15:03 -0400
Received: from wire.cadcamlab.org ([156.26.20.181]:15879 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S132737AbRDQQOs>; Tue, 17 Apr 2001 12:14:48 -0400
Date: Tue, 17 Apr 2001 11:14:26 -0500
To: John Cowan <cowan@mercury.ccil.org>
Cc: esr@thyrsus.com, james rich <james.rich@m.cc.utah.edu>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.1.3 is available
Message-ID: <20010417111426.A24230@cadcamlab.org>
In-Reply-To: <20010416205556.A22960@thyrsus.com> <E14pTOH-0007ex-00@mercury.ccil.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E14pTOH-0007ex-00@mercury.ccil.org>; from cowan@mercury.ccil.org on Tue, Apr 17, 2001 at 07:11:25AM -0400
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[John Cowan]
> The whole point of CML2 is to make kernel configuration something
> that Aunt Tillie (or a reasonable facsimile thereof) can do, and we
> are all Aunt Tillies from time to time.  That includes differing
> standards of readability,

Come on, that's absolutely a red herring.  There are valid reasons to
want to configure your color schemes, but Aunt Tillie is not one of
them.  Do you seriously believe the novice user will ever futz with a
~/.kernelconfigrc file?  I don't.  Only the (relatively) advanced user
will bother to figure out stuff like that.

If you want your aunt to be able to set her own colors, you basically
have to provide an 'Edit / Preferences...' drop-down or equivalent, and
I think we all know we don't want to go *there*....

> Without counting, I estimate that 50% of the problem (I won't say
> "bug" in this context) reports you have had since 1.0.0 have been
> about colors.

Which basically means Eric and the others have long since shaken out
the serious bugs.  -- Except for the famous 20-second parse, which of
course accounts for the *other* 50% of recent CML2 traffic.

Peter
