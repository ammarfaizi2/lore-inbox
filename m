Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280064AbRKEATy>; Sun, 4 Nov 2001 19:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280062AbRKEATo>; Sun, 4 Nov 2001 19:19:44 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:7435 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S280071AbRKEATc>;
	Sun, 4 Nov 2001 19:19:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Lonnie Cumberland <lonnie@outstep.com>
Subject: Re: Special Kernel Modification
Date: Sun, 4 Nov 2001 16:19:23 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3BE5D6EC.8040204@outstep.com>
In-Reply-To: <3BE5D6EC.8040204@outstep.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E160XU3-00012T-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 4, 2001 16:01, Lonnie Cumberland wrote:
> I have look into using things like "chroot" to restrict the users for
> this very special server, but that solution is not what we need.
....
> Is there someone who might be able to give me some information on how I
> could add a few lines to the VFS filesystem so that I might set some
> type of extended attribute to prevent users from navigating out of the
> locations.

I fail to see the difference between "chroot" and "preventing users from 
navigating out of locations". Would you care to clarify what was wrong was 
chroot that you believe you can solve with a different approach?
-Ryan
