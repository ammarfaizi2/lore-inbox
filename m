Return-Path: <linux-kernel-owner+w=401wt.eu-S1750944AbXAUPwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbXAUPwv (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 10:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbXAUPwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 10:52:50 -0500
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:3870 "EHLO
	smtp-vbr5.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbXAUPwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 10:52:49 -0500
Date: Sun, 21 Jan 2007 16:52:19 +0100
From: thunder7@xs4all.nl
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Avuton Olrich <avuton@gmail.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: 2.6.19.2, cp 18gb_file 18gb_file.2 = OOM killer, 100% reproducible
Message-ID: <20070121155219.GA7413@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <Pine.LNX.4.64.0701201516450.3684@p34.internal.lan> <3aa654a40701201245s72b2f76hc70ddd94b70ba99c@mail.gmail.com> <Pine.LNX.4.64.0701201602570.4910@p34.internal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701201602570.4910@p34.internal.lan>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Sat, Jan 20, 2007 at 04:03:42PM -0500
> 
> 
> My swap is on, 2GB ram and 2GB of swap on this machine.  I can't go back 
> to 2.6.17.13 as it does not recognize the NICs in my machine correctly and 
> the Alsa Intel HD Audio driver has bugs etc, I guess I am stuck with 
> 2.6.19.2 :(
> 
Well, if you can't go back, you could always test 2.6.20-rc5. That's why
it's out there :-) It can't be any worse!

Good luck,
Jurriaan
-- 
It might look like I'm doing nothing, but at the cellular level I'm really
quite busy.
	Hans Haas
Debian (Unstable) GNU/Linux 2.6.20-rc5 2x2011 bogomips load 1.97
the Jack Vance Integral Edition: http://www.integralarchive.org
