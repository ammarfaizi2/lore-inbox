Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311714AbSCNS1H>; Thu, 14 Mar 2002 13:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311716AbSCNS05>; Thu, 14 Mar 2002 13:26:57 -0500
Received: from zero.tech9.net ([209.61.188.187]:15883 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S311714AbSCNS0q>;
	Thu, 14 Mar 2002 13:26:46 -0500
Subject: Re: Linux 2.4 and BitKeeper
From: Robert Love <rml@tech9.net>
To: Ben Greear <greearb@candelatech.com>
Cc: Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C90E994.2030702@candelatech.com>
In-Reply-To: <Pine.LNX.4.21.0203140141450.4725-100000@freak.distro.conectiva>
	<3C904437.7080603@candelatech.com> <20020313224255.F9010@work.bitmover.com>
	 <3C90E994.2030702@candelatech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 14 Mar 2002 13:26:40 -0500
Message-Id: <1016130404.4289.5.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-03-14 at 13:19, Ben Greear wrote:

> I did a clone with this.  However, I see no files, only
> directories.  The files do seem to be in the SCCS directories,
> but I don't know how to make them appear in their normal place.

Uh that is how BK works.  The files are stored.  Try

	bk -r co

to get all the files.  Omit the `-r' to check out only the current
directory.

There are some decent tutorials and such on bitmovers[1] page.

[1] http://www.bitmover.com

	Robert Love

