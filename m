Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318488AbSIFLrE>; Fri, 6 Sep 2002 07:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318516AbSIFLrE>; Fri, 6 Sep 2002 07:47:04 -0400
Received: from speech.linux-speakup.org ([129.100.109.30]:35024 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S318488AbSIFLrD>; Fri, 6 Sep 2002 07:47:03 -0400
To: <Hell.Surfers@cwctv.net>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.5.xx kernels won't run on my Athlon boxes
References: <0d6c95254000692DTVMAIL12@smtp.cwctv.net>
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 06 Sep 2002 07:51:40 -0400
In-Reply-To: <0d6c95254000692DTVMAIL12@smtp.cwctv.net>
Message-ID: <x71y879vzn.fsf@speech.braille.uwo.ca>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<Hell.Surfers@cwctv.net> writes:

> I was going to suggest a kernel check from the begining of 2.4ac to see if the problem occurs at some point, as major features are usually stuck in from them first...

The 2.4.19 kernels seem to be fine on the box unless it's right after
I've rebooted from 2.5.33.  Then 2.4.19 seems to be flakey in various
interesting ways until I do a full shut off of the hardware and turn
it back on.  Usually when I'm seeing problems under 2.4.19 they seem
to be vm errors in processes.  It really likes to kill off my
setiathome process with a vm error.  It's very consistant.  I run a
twenty minute cron job to restart setiathome and vm kills it almost
immediately.  Of course, I shut down the box and turn it off and when
it comes back up it runs fine until I restart under 2.5 again.  Then
five minutes or so and it's dead in the water again.

  Kirk

-- 

Kirk Reiser				The Computer Braille Facility
e-mail: kirk@braille.uwo.ca		University of Western Ontario
phone: (519) 661-3061
