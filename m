Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273058AbRIOVER>; Sat, 15 Sep 2001 17:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273054AbRIOVEH>; Sat, 15 Sep 2001 17:04:07 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26362
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S273058AbRIOVEE>; Sat, 15 Sep 2001 17:04:04 -0400
Date: Sat, 15 Sep 2001 14:04:22 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ext2fs corruption again
Message-ID: <20010915140422.B24067@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3BA33818.8030503@korseby.net> <20010915122113.A24561@grobbebol.xs4all.nl> <3BA36A72.20702@korseby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA36A72.20702@korseby.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2001 at 04:49:22PM +0200, Kristian wrote:
> I'll try to use 'hdparm -d1 -X33 /dev/hda' and other modes to see if it occurs 
> again. But testing could take some time. It appears ~~ every second day.
> 
> Kristian
> 

If it takes that long, then make sure you start with ''hdparm -d0 /dev/hda'.

Mike
