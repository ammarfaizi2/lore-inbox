Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277905AbRJWQVf>; Tue, 23 Oct 2001 12:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277910AbRJWQVZ>; Tue, 23 Oct 2001 12:21:25 -0400
Received: from smtp3.libero.it ([193.70.192.53]:44226 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S277905AbRJWQVM>;
	Tue, 23 Oct 2001 12:21:12 -0400
Date: Tue, 23 Oct 2001 18:15:01 +0200
From: antirez <antirez@invece.org>
To: DevilKin <DevilKin@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More memory == better?
Message-ID: <20011023181501.A6821@blu>
Reply-To: antirez <antirez@invece.org>
In-Reply-To: <20011023161340.02EAC9BD76@pop3.telenet-ops.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011023161340.02EAC9BD76@pop3.telenet-ops.be>; from DevilKin@gmx.net on Tue, Oct 23, 2001 at 06:10:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2001 at 06:10:38PM +0200, DevilKin wrote:
[snip]
> I must say that even with most of my applications loaded/running, the system 
> never even touches the swap partition.
> 
> So, would it be wise?

If the applications you run are very disk-intensive probably the
answer is yes, since free memory is used as disk cache.

-- 
Salvatore Sanfilippo <antirez@invece.org>
http://www.kyuzz.org/antirez
finger antirez@tella.alicom.com for PGP key
28 52 F5 4A 49 65 34 29 - 1D 1B F6 DA 24 C7 12 BF
