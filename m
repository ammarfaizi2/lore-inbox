Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbTAAPCn>; Wed, 1 Jan 2003 10:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267242AbTAAPCn>; Wed, 1 Jan 2003 10:02:43 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:13503 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267241AbTAAPCm>; Wed, 1 Jan 2003 10:02:42 -0500
Date: Wed, 1 Jan 2003 16:11:07 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a few more "make xconfig" inconsistencies
Message-ID: <20030101151107.GN14184@louise.pinerecords.com>
References: <20030101145120.GL14184@louise.pinerecords.com> <200301011504.h01F4Gxt001123@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301011504.h01F4Gxt001123@darkstar.example.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [john@grabjohn.com]
> 
> > Oh, I see what you mean.  This behavior is a "feature" of the old
> > xconfig (it's been so since the 2.0 times or thereabouts). menuconfig
> > will hide entirely what xconfig merely grays out.
> 
> I actually like that feature :-(.
> 
> On the other hand, the TCL-based config system has gone completely in
> 2.5.  I look forward to the 2.7 tree opening when hopefully somebody
> will bring it back as an extra choice, just for the sake of it :-).

The new config system provides a generic library for handling kernel
configuration.  My bet is we can expect lots of kernel config frontends
turning up as soon as 2.6 sees the light of the world (and people find
out how great it is :D).

-- 
Tomas Szepe <szepe@pinerecords.com>
