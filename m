Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132296AbQKDBcX>; Fri, 3 Nov 2000 20:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132326AbQKDBcN>; Fri, 3 Nov 2000 20:32:13 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:47378 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S132296AbQKDBcD>; Fri, 3 Nov 2000 20:32:03 -0500
Date: Fri, 3 Nov 2000 19:31:51 -0600
To: matthew <matthew@mattshouse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10 Sluggish After Load
Message-ID: <20001103193151.K1041@wire.cadcamlab.org>
In-Reply-To: <Pine.LNX.4.21.0011021152310.15168-100000@duckman.distro.conectiva> <Pine.LNX.4.21.0011021016120.12598-100000@matthew.linuxnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011021016120.12598-100000@matthew.linuxnet>; from matthew@mattshouse.com on Thu, Nov 02, 2000 at 10:22:22AM -0600
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[matthew]
> ls /proc > killscript
> added "kill -9" to the beginning and "\" to the end of each line,
> ran it as the database user.  It worked pretty well.

Sounds like a lot of trouble.

  su {oracle} -c 'kill -9 -1'

Or is there some reason that wouldn't have worked in your case?

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
