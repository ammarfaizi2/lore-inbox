Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131459AbRCSLpe>; Mon, 19 Mar 2001 06:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131460AbRCSLpY>; Mon, 19 Mar 2001 06:45:24 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:31559 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S131459AbRCSLpP>; Mon, 19 Mar 2001 06:45:15 -0500
Date: Mon, 19 Mar 2001 13:44:16 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [OT] how to catch HW fault
Message-ID: <20010319134416.F5316@niksula.cs.hut.fi>
In-Reply-To: <A9FD1B186B99D4119BCC00D0B75B4D8104D4AA30@xch01ykf.rim.net> <Pine.LNX.4.21.0103182107460.20316-100000@schoen3.schoen.nl> <20010319123519.E5316@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010319123519.E5316@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Mon, Mar 19, 2001 at 12:35:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2001 at 12:35:19PM +0200, you [Ville Herva] claimed:
> I quickly hacked up an user space memory tester, and sure enough it
> reported an error after five

If anyone is interested in the said hack (some already mailed me that they
are), I made it available at

http://v.iki.fi/~vherva/memburn.c

Disclaimer: it's just a quick hack, please use memtest86 if possible.
Memburn does have one found memory error under its belt, though ;).


-- v --

v@iki.fi
