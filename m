Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267264AbTAAPQf>; Wed, 1 Jan 2003 10:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267254AbTAAPQf>; Wed, 1 Jan 2003 10:16:35 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:17599 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267264AbTAAPQd>; Wed, 1 Jan 2003 10:16:33 -0500
Date: Wed, 1 Jan 2003 16:24:57 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: John Bradford <john@grabjohn.com>
Cc: rpjday@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: a few more "make xconfig" inconsistencies
Message-ID: <20030101152457.GA15200@louise.pinerecords.com>
References: <20030101145120.GL14184@louise.pinerecords.com> <200301011521.h01FLq6r001565@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301011521.h01FLq6r001565@darkstar.example.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [john@grabjohn.com]
> 
> In 2.5.53, under Old CD-ROM drivers (not SCSI, not IDE), if you select
> "Matsushita/Panasonic/Creative, Longshine, TEAC CDROM support", the
> help text says:
> 
> "This driver can support up to four CD-ROM controller cards, and each
> card can support up to four CD-ROM drives; if you say Y here, you will
> be asked how many controller cards you have."
> 
> The user is not prompted to specify how many controllers they have in
> 2.5.53, and in 2.4.20-pre2, there are separate options for the 2nd,
> 3rd, and 4th controllers.
> 
> However, I've looked through the code, and I'm not sure if >1
> controller is actually supported anymore - a lot of the code for that
> seems to be commented out in 2.4.20-pre2, and completely removed in
> 2.5.53.

You'll need to ask the driver's maintainer (if there is one at all,
that is).

-- 
Tomas Szepe <szepe@pinerecords.com>
