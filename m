Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129495AbRBZSDl>; Mon, 26 Feb 2001 13:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129492AbRBZSDd>; Mon, 26 Feb 2001 13:03:33 -0500
Received: from mail.mediaways.net ([193.189.224.113]:39932 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S129473AbRBZSDO>; Mon, 26 Feb 2001 13:03:14 -0500
Date: Mon, 26 Feb 2001 18:16:34 +0100
From: Walter Hofmann <walter.hofmann@physik.stud.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18/ext2: special file corruption?
Message-ID: <20010226181634.A5097@frodo.uni-erlangen.de>
In-Reply-To: <3A9A2E3D.9135.8E1BCE@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A9A2E3D.9135.8E1BCE@localhost>; from Ulrich.Windl@rz.uni-regensburg.de on Mon, Feb 26, 2001 at 10:21:51AM +0100
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Windl schrieb am Montag, den 26. Februar 2001:

> I had an interesting effect: Due to NVdriver I had a lot of system 
> freezes, and I had to reboot. Using e2fsck 1.19a (SuSE 7.1) I got the 
> message that one specific "Special (device/socket/fifo) inode .. has 
> non-zero size. FIXED."

I see them too on every fsck (after a crash). I'm using e2fsck 1.19 (but
not from SuSE. The rpm was built on snap.thunk.org, but I can't
remember where I got it from).

Walter
