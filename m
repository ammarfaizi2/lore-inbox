Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266433AbSKLJn2>; Tue, 12 Nov 2002 04:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266434AbSKLJn1>; Tue, 12 Nov 2002 04:43:27 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:20652 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S266433AbSKLJn1>; Tue, 12 Nov 2002 04:43:27 -0500
To: rudmer@legolas.dynup.net
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] devfs API
References: <20021112013244.GF1729@mythical.michonline.com>
	<Pine.GSO.4.21.0211112039430.29617-100000@steklov.math.psu.edu>
	<20021112080417.GA11660@think.thunk.org>
	<20021112083811Z266406-32598+5165@vger.kernel.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 12 Nov 2002 18:50:11 +0900
In-Reply-To: <20021112083811Z266406-32598+5165@vger.kernel.org>
Message-ID: <buo3cq7yv58.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudmer van Dijk <rudmer@legolas.dynup.net> writes:
> from a user point of view it is better to keep it because it could really 
> simplify a users life except ide should be just in discs as hdX and not as 
> /dev/ide/hostN/busX/targetY/lunZ/disc ...

Of course, that should really be `disk' (judging from general kernel usage)...

-Miles
-- 
.Numeric stability is probably not all that important when you're guessing.
