Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRCZUQD>; Mon, 26 Mar 2001 15:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129156AbRCZUPy>; Mon, 26 Mar 2001 15:15:54 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:34578 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129112AbRCZUPn>;
	Mon, 26 Mar 2001 15:15:43 -0500
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andreas Dilger <adilger@turbolinux.com>, LA Walsh <law@sgi.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
In-Reply-To: <20010326181803.F31126@parcelfarce.linux.theplanet.co.uk> <200103261747.f2QHlEX19564@webber.adilger.int> <20010326190945.I31126@parcelfarce.linux.theplanet.co.uk>
From: Jes Sorensen <jes@linuxcare.com>
Date: 26 Mar 2001 22:14:06 +0200
In-Reply-To: Matthew Wilcox's message of "Mon, 26 Mar 2001 19:09:45 +0100"
Message-ID: <d33dc01e5t.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Matthew" == Matthew Wilcox <matthew@wil.cx> writes:

Matthew> On Mon, Mar 26, 2001 at 10:47:13AM -0700, Andreas Dilger
Matthew> wrote:
>> What do you mean by problems 5 years down the road?  The real issue
>> is that this 32-bit block count limit affects composite devices
>> like MD RAID and LVM today, not just individual disks.  There have
>> been several postings I have seen with people having a problem
>> _today_ with a 2TB limit on devices.

Matthew> people who can afford 2TB of disc can afford to buy a 64-bit
Matthew> processor.

Oh great, and migrating a large application to a new architecture is
soo cheap. Disk costs nothing these days and there is a legitimate
need here.

Jes
