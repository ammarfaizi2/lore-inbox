Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319363AbSIFT52>; Fri, 6 Sep 2002 15:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319365AbSIFT52>; Fri, 6 Sep 2002 15:57:28 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:13847 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S319363AbSIFT51>;
	Fri, 6 Sep 2002 15:57:27 -0400
From: <Hell.Surfers@cwctv.net>
To: kirk@braille.uwo.ca, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Date: Fri, 6 Sep 2002 20:59:22 +0100
Subject: RE:Re: 2.5.xx kernels won't run on my Athlon boxes
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1031342362044"
Message-ID: <0c40b1758190692DTVMAIL7@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1031342362044
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

If you have coding knowledge, you can cross write 2.5 with 2.4 IDE code... Lotsof people could help you, BUT i dont think it would be as easy as it sounds...



On 	06 Sep 2002 07:51:40 -0400 	Kirk Reiser <kirk@braille.uwo.ca> wrote:

--1031342362044
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Fri, 6 Sep 2002 12:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318488AbSIFLrE>; Fri, 6 Sep 2002 07:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318516AbSIFLrE>; Fri, 6 Sep 2002 07:47:04 -0400
Received: from speech.linux-speakup.org ([129.100.109.30]:35024 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S318488AbSIFLrD>; Fri, 6 Sep 2002 07:47:03 -0400
Received: from kirk by speech.braille.uwo.ca with local (Exim 3.35 #1 (Debian))
	id 17nHeG-0007VT-00; Fri, 06 Sep 2002 07:51:40 -0400
To: <Hell.Surfers@cwctv.net>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.5.xx kernels won't run on my Athlon boxes
References: <0d6c95254000692DTVMAIL12@smtp.cwctv.net>
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 06 Sep 2002 07:51:40 -0400
In-Reply-To: <0d6c95254000692DTVMAIL12@smtp.cwctv.net>
Message-ID: <x71y879vzn.fsf@speech.braille.uwo.ca>
Lines: 22
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1031342362044--


