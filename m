Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285032AbRLKPB4>; Tue, 11 Dec 2001 10:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285046AbRLKPBg>; Tue, 11 Dec 2001 10:01:36 -0500
Received: from mailgate.bodgit-n-scarper.com ([62.49.233.146]:58630 "HELO
	mould.bodgit-n-scarper.com") by vger.kernel.org with SMTP
	id <S285032AbRLKPB0>; Tue, 11 Dec 2001 10:01:26 -0500
Date: Tue, 11 Dec 2001 15:07:17 +0000
From: Matt <matt@bodgit-n-scarper.com>
To: linux-kernel@vger.kernel.org
Subject: aacraid success with 2.4.17-pre8. Intentional?
Message-ID: <20011211150717.A20308@mould.bodgit-n-scarper.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 on i686 SMP (mould)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to set up an HP NetRaid 4M controller, (aacraid), and I got
the familiar fsck hang with both the latest drivers provided by Matt Domsch,
and Alan Cox, under kernel 2.4.16.

I've just tried the latest 2.4.17-pre8 kernel, and it works, in that
it gets passed the fsck'ing. I couldn't see anything in the changelog that
screamed "Fix fsck hang with aacraid", so I was wondering if my working
setup is intentional or not? I haven't followed the development of this
driver too closely, I just had the card and downloaded the latest "stable"
release and went from there...

Searching the archives, I couldn't see anyone reporting a success with this
kernel and card combination, which worried me slightly. Have I got something
that will fall over if I sneeze near it? :-)

Cheers

Matt
-- 
"Phase plasma rifle in a forty-watt range?"
"Only what you see on the shelves, buddy"
