Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278511AbRJ3Wro>; Tue, 30 Oct 2001 17:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278494AbRJ3Wr2>; Tue, 30 Oct 2001 17:47:28 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:41484 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S278505AbRJ3WrJ>; Tue, 30 Oct 2001 17:47:09 -0500
Date: Fri, 26 Oct 2001 13:32:31 +0000
From: Pavel Machek <pavel@suse.cz>
To: volodya@mindspring.com
Cc: livid-gatos@linuxvideo.org, video4linux-list@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] alternative kernel multimedia API
Message-ID: <20011026133231.B38@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.20.0110251258510.8566-200000@node2.localnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.20.0110251258510.8566-200000@node2.localnet.net>; from volodya@mindspring.com on Thu, Oct 25, 2001 at 01:06:12PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

One thing current interface can not do is to put driver into userspace.

And yes, we *need* userspace devices for many cams, as you will be shot
if you try to do format conversion in kernel.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

