Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130883AbQLNLwx>; Thu, 14 Dec 2000 06:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132224AbQLNLwn>; Thu, 14 Dec 2000 06:52:43 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:42183 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S130883AbQLNLwY>; Thu, 14 Dec 2000 06:52:24 -0500
Date: Thu, 14 Dec 2000 13:21:18 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: test12 lockups -- need feedback
Message-ID: <20001214132118.A829@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.30.0012132157020.1272-100000@viper.haque.net> <Pine.LNX.4.30.0012132244290.1875-100000@viper.haque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.30.0012132244290.1875-100000@viper.haque.net>; from mhaque@haque.net on Wed, Dec 13, 2000 at 10:48:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2000 at 10:48:56PM -0500, Mohammad A. Haque wrote:
> Trace; c0105000 <empty_bad_page+0/1000>
> Trace; c0100191 <L6+0/2>

I locked a Cyrix III machine up on boot and hat these both
elements in my trace, too.

It Oopsed and locked up after the Message: "CPU: Before vendor
init".

I locked up too with another machine (Pentium Classic) but like
all others by using X.

I have no oops yet of this lockup, because of X, but I'll ask a
friend of mine, whether the remote logging made it to him and
send you the results.

PS: I tried test12-pre8, so its inside test12-pre8 already.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
