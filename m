Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135288AbRASQOK>; Fri, 19 Jan 2001 11:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135341AbRASQNv>; Fri, 19 Jan 2001 11:13:51 -0500
Received: from mail.rd.ilan.net ([216.27.80.130]:10756 "EHLO mail.rd.ilan.net")
	by vger.kernel.org with ESMTP id <S135288AbRASQNp>;
	Fri, 19 Jan 2001 11:13:45 -0500
Message-ID: <3A6867B1.C4818A70@holly-springs.nc.us>
Date: Fri, 19 Jan 2001 11:13:37 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mo McKinlay <mmckinlay@gnu.org>
CC: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <Pine.LNX.4.30.0101191606270.2331-100000@nvws005.nv.london>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mo McKinlay wrote:

> Nono, that's not what I mean - each of the filesystems fails if it
> doesn't support what you're trying to do, that's given - but having a
> different delimeter registered by the filesystem (and hence the
> possibility of every single filesystem using a different delimeter) brings
> about a completely different kind of inconsistency.

True. Which is why I'd prefer a standard delimiter. ":" seems to be the
top candidate.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
