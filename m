Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267641AbRG0POS>; Fri, 27 Jul 2001 11:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267645AbRG0POL>; Fri, 27 Jul 2001 11:14:11 -0400
Received: from jffdns01.or.intel.com ([134.134.248.3]:964 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S267641AbRG0PNy>; Fri, 27 Jul 2001 11:13:54 -0400
Message-ID: <9678C2B4D848D41187450090276D1FAE1008EAB1@FMSMSX32>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'Chris Wedgwood'" <cw@f00f.org>, Hans Reiser <reiser@namesys.com>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: RE: ReiserFS / 2.4.6 / Data Corruption
Date: Fri, 27 Jul 2001 08:13:08 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

-----Original Message-----
On Fri, Jul 27, 2001 at 06:55:09PM +0400, Hans Reiser wrote:
    Don't use RedHat with ReiserFS, they screw things up so many
    ways.....

    For instance, they compile it with the wrong options set, their
    boot scripts are wrong, they just shovel software onto the CD.
[...]
>Chris Wedgewood wrote:
>Since so many people seem to run RedHat, perhaps it's worth someone
>determining exactly what is busted with their init scripts or whatever
>that makes reiserfs barf more often that with other distributions.
---
Yes, I would be very interested in a tips/HOWTO on how to fix the compile
options, boot scripts, etc. for RedHat 7.1.  I've been struggling with a
software RAID1 configuration with reiserfs on root and Redhat 7.1.  

Andy Cress



