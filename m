Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288173AbSBIDkW>; Fri, 8 Feb 2002 22:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288248AbSBIDkM>; Fri, 8 Feb 2002 22:40:12 -0500
Received: from [63.231.122.81] ([63.231.122.81]:54367 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S288173AbSBIDj4>;
	Fri, 8 Feb 2002 22:39:56 -0500
Date: Fri, 8 Feb 2002 20:39:31 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [bk patch] Make cardbus compile in -pre4
Message-ID: <20020208203931.X15496@lynx.turbolabs.com>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org>; from mochel@osdl.org on Fri, Feb 08, 2002 at 06:25:17PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 08, 2002  18:25 -0800, Patrick Mochel wrote:
> (I don't have a public repository yet, so there's no place to pull form)

I don't see why everyone who is using BK is expecting Linus to do a pull.
In the non-BK case, wasn't it always a "push" model, and Linus would not
"pull" from URLs and such?  Why are people not simply doing:

!bk send -r+ (other options) - 

from within their editor (or equivalent) to inline the CSET in the email?
This has the added advantage that other people reading the email can also
import the CSET immediately if they so desire.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

