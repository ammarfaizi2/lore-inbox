Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSC1Bw4>; Wed, 27 Mar 2002 20:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311424AbSC1Bwr>; Wed, 27 Mar 2002 20:52:47 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:29429
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S290289AbSC1Bwe>; Wed, 27 Mar 2002 20:52:34 -0500
Date: Wed, 27 Mar 2002 17:54:16 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: root <root@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bkbits.net down
Message-ID: <20020328015416.GB8627@matchmail.com>
Mail-Followup-To: root <root@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200203271853.g2RIrRv11812@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2002 at 10:53:27AM -0800, root wrote:
> It looks like we have a bad disk, I'm checking them now to figure out if 
> it is the the primary or backup data drive.  I'll run checks in all the
> repositories if fsck doesn't find the problem so it may take a couple of 
> hours before we are back up.
> 
> In the not so distant future, we're moving the backup drive to a different
> machine such that we can just flip machines when this happens but for now
> you'll have to wait for a bit.

Or use RAID1/5...
