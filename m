Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265885AbTAFDuj>; Sun, 5 Jan 2003 22:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265895AbTAFDuj>; Sun, 5 Jan 2003 22:50:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1546 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265885AbTAFDui>; Sun, 5 Jan 2003 22:50:38 -0500
Date: Sun, 5 Jan 2003 19:54:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, <akpm@zip.com.au>,
       Thomas Sailer <sailer@ife.ee.ethz.ch>,
       Marcel Holtmann <marcel@holtmann.org>,
       Jose Orlando Pereira <jop@di.uminho.pt>,
       <J.E.J.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] Deprecated exec_usermodehelper, enhance call_usermodehelper
In-Reply-To: <20030106015436.B5FC22C10E@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0301051952450.3087-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Jan 2003, Rusty Russell wrote:
>
> Linus, please apply.

Nope, I really don't want to deprecate any more interfaces while my build 
is still so noisy about the _existing_ deprecated stuff.

The noisiness of the current build is quite distracting, and likely makes 
people just ignore potentially valid warnings simply because there are too 
many of them-

		Linus

