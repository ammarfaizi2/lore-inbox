Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265271AbUBJDQD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 22:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265306AbUBJDQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 22:16:03 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:23019 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265271AbUBJDQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 22:16:01 -0500
Date: Mon, 9 Feb 2004 22:15:56 -0500
From: Willem Riede <wrlk@riede.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.3-rc1] ide-scsi burning broken
Message-ID: <20040210031556.GK28026@serve.riede.org>
Reply-To: wrlk@riede.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Feb 2004 20:10:37 +0200, Markus Hästbacka wrote:
                
> Hi list,
> I was going to burn a cd earlier today, and I noticed it wont work in
> 2.6.3-rc1, k3b (the burning software) just freezed in 'D' state, and
> after a moment I got something like this in my dmesg:
> /dec/sr0 drive not ready!
> /dec/sr0 drive not ready!
> /dec/sr0 drive not ready!
> [x1000]
> So I guess the ide-scsi patches broke up things.
>
> The burning in 2.6.1-mm4 works fine.
>
> I know I should use ide-cd whatever, but I've always done it with
> ide-scsi and I wont easily change that.
                
I doubt that changes in ide-scsi caused this, you just ran out of luck :-(
Since you're not supposed to use ide-scsi for cd writing (as you admit
knowing), nobody is going to help you with this problem...
                
Sorry, Willem Riede.
