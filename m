Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbTAaVVv>; Fri, 31 Jan 2003 16:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbTAaVVv>; Fri, 31 Jan 2003 16:21:51 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:15629 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S262425AbTAaVVv>;
	Fri, 31 Jan 2003 16:21:51 -0500
Date: Fri, 31 Jan 2003 16:31:09 -0500 (EST)
Message-Id: <200301312131.h0VLV91470737@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Cc: davej@codemonkey.org.uk, john@grabjohn.com, alan@lxorguk.ukuu.org.uk,
       szepe@pinerecords.com
Subject: Re: [PATCH] 2.5.59 morse code panics
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dave Jones writes:
> On Fri, Jan 31, 2003 at 02:29:59PM +0000, John Bradford wrote:

>> On the other hand, I don't actually want to have to listen
>> to ten minutes of morse code over the phone when another
>> box could do it for me.
>
> That must be a pretty quiet datacentre. And what happens
> when more than one box starts beeping ?

a. Supposedly a good ham can pick one signal from many,
   at least if the pitches are different.

b. If you're not a good ham, you can process the audio.
   There are existing decoders that might do the job.
   This works for 1 computer if you have a tape recorder.

Using fast Morse over the speaker, an oops may take
30 minutes.

Blinking keyboard LEDs would have to be much slower.
The data would have to be just an instruction pointer.

Using a non-Morse code over the speaker could get the
transmission time down to a couple minutes, with full
ASCII and error correction.

Say, anybody have a *.wav file of machine-room noise?
(16-bit, 44.1 and 48 kHz)
