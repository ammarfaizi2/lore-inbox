Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbSLNRk7>; Sat, 14 Dec 2002 12:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265426AbSLNRk7>; Sat, 14 Dec 2002 12:40:59 -0500
Received: from windsormachine.com ([206.48.122.28]:10511 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S265424AbSLNRk6>; Sat, 14 Dec 2002 12:40:58 -0500
Date: Sat, 14 Dec 2002 12:48:46 -0500 (EST)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <20021214100125.GA30545@suse.de>
Message-ID: <Pine.LNX.4.33.0212141247340.21917-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Dec 2002, Dave Jones wrote:

> Note that there are more factors at play than raw cpu speed in a
> kernel compile. Your time here is slightly faster than my 2.8Ghz P4-HT for
> example.  My guess is you have faster disk(s) than I do, as most of
> the time mine seems to be waiting for something to do.

Quantum Fireball AS's in that machine.  My main comment was that his
Althon MP at 1.8 was half or less the speed of a single P4.  Even with
compiler changes, I wouldn't think it would make THAT much of a
difference?

Mike

