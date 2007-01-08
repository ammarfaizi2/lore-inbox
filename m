Return-Path: <linux-kernel-owner+w=401wt.eu-S965304AbXAHUkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965304AbXAHUkh (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 15:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbXAHUkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 15:40:37 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:48265 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932659AbXAHUkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 15:40:36 -0500
Date: Mon, 8 Jan 2007 21:39:05 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jay Vaughan <jv@access-music.de>
cc: Dirk <d_i_r_k_@gmx.net>, Trent Waddington <trent.waddington@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Gaming Interface
In-Reply-To: <a06230924c1c7d795429a@[192.168.2.101]>
Message-ID: <Pine.LNX.4.61.0701082138050.23737@yvahk01.tjqt.qr>
References: <45A22D69.3010905@gmx.net> <3d57814d0701080243n745fcddg8eaace0093e88a38@mail.gmail.com>
 <45A2356B.5050208@gmx.net> <a06230924c1c7d795429a@[192.168.2.101]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 8 2007 12:17, Jay Vaughan wrote:
> At 13:13 +0100 8/1/07, Dirk wrote:
>> Trent Waddington wrote:
>> > Call me crazy, but game manufacturers want directx right?  You aint
>> > running that in the kernel.
>>
>> They want something like DirectX that changes it's API less frequent
>> than DirectX and that compiles as a module because you don't want to run
>> it in the kernel.
>
> Whats wrong with just using SDL/OpenGL?

SDL is slow, at least for software rendering (not that I advocate it 
being put into the kernel):

http://forum.zdoom.org/potato.php?t=1913 (hope you can decipher the html table)


	-`J'
-- 
