Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317610AbSG2Tzt>; Mon, 29 Jul 2002 15:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317616AbSG2Tzt>; Mon, 29 Jul 2002 15:55:49 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:19725 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317610AbSG2Tzm>;
	Mon, 29 Jul 2002 15:55:42 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207291957.g6TJvIl158896@saturn.cs.uml.edu>
Subject: Re: [PATCH -ac] Panicking in morse code
To: davidsen@tmr.com (Bill Davidsen)
Date: Mon, 29 Jul 2002 15:57:18 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
       j.schmidt@paradise.net.nz (Jens Schmidt), root@chaos.analogic.com,
       phillips@arcor.de (Daniel Phillips), arodland@noln.com (Andrew Rodland),
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1020729074834.30577B-100000@gatekeeper.tmr.com> from "Bill Davidsen" at Jul 29, 2002 07:50:04 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen writes:
> On Fri, 26 Jul 2002, Albert D. Cahalan wrote:
>> Jens Schmidt writes:

>>> I am not a "morse" guy myself, but appreciate this idea.
>>
>> Yeah, same here. I have to wonder if morse is the
>> best encoding, since many people don't know it.
>> The vast majority of us would need a microphone and
>> translator program anyway, so a computer-friendly
>> encoding makes more sense. Modems don't do morse.
>
> What other widely known encoding for blinking lights did you have in mind.
> Clearly there are more people who know morse than any other encoding you
> could make up, and even those who don't know it would know what it is.

ROTFL

This is NOT morse over blinking lights. Even at 12 WPM,
which is moderately fast, you'd have to stare at the
lights for over an hour without blinking! Keep in mind
that people know morse by sound, not sight, so you'd
have to slow it down. Maybe 24 hours for an oops?

(note: in morse, hex digits are slow)

No, the lights just blink. Encoding just the instruction
pointer, in binary, might be worthwhile. I have doubts.

As for the audio... you can copy morse for over an hour
or you can tape record 4 minutes of noise. Hard choice?
