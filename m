Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311462AbSCNBJl>; Wed, 13 Mar 2002 20:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311464AbSCNBJa>; Wed, 13 Mar 2002 20:09:30 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:24827
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S311462AbSCNBJU>; Wed, 13 Mar 2002 20:09:20 -0500
Date: Wed, 13 Mar 2002 17:10:25 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Amir Kazerouninia <amirk@ucla.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New kernel reboots machine during boot up
Message-ID: <20020314011025.GA363@matchmail.com>
Mail-Followup-To: Amir Kazerouninia <amirk@ucla.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <ECEBJPOCCIGHNECIGEPDEEGDCAAA.amirk@ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ECEBJPOCCIGHNECIGEPDEEGDCAAA.amirk@ucla.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 02:36:18PM -0800, Amir Kazerouninia wrote:
> Hello,
> 	The kernel I just compiled is the 2.4.18 kernel. LILO deals with the large
> drive fine when booting the previous 2.2.19 kernel. I compiled the new one
> from scratch with no networking support and very little else. The problem
> basically occurs right at boot, it doesn't matter if I use a floppy to boot
> or my haddrive. The problem with the harddrive is that I'll get a loading
> vmlinuz-2.4.18......... and then it reboots. I haven't been able to pause it
> to get a clear picture of what is happening. The floppy is a little easier
> because what happens is that it says Loading, gives a series of dots and
> then reboots. Any suggestions would be greatly appreciated. Thanks in
> advance for suggestions.

You have probably optimized your kernel for the wrong processor.  Double
check that and try again.
