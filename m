Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268246AbTALGzw>; Sun, 12 Jan 2003 01:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268247AbTALGzw>; Sun, 12 Jan 2003 01:55:52 -0500
Received: from vitelus.com ([64.81.243.207]:17676 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S268246AbTALGzv>;
	Sun, 12 Jan 2003 01:55:51 -0500
Date: Sat, 11 Jan 2003 23:03:52 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>, linux-kernel@vger.kernel.org
Subject: Re: some curiosities on the filesystems layout in kernel config
Message-ID: <20030112070352.GL31238@vitelus.com>
References: <Pine.LNX.4.44.0301120053420.21687-100000@dell> <20030112065921.GA18290@kanoe.ludicrus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030112065921.GA18290@kanoe.ludicrus.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 10:59:21PM -0800, Joshua M. Kwan wrote:
> > 3) currently, since quotas are only supported for ext2, ext3 and
> >    reiserfs, shouldn't quotas depend on at least one of those
> >    being selected?
> 
> Not sure whether this is true, I'm not quite sure.

You could compile any of these filesystems as modules.
