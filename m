Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143708AbRAHOd4>; Mon, 8 Jan 2001 09:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143752AbRAHOdq>; Mon, 8 Jan 2001 09:33:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:22200 "EHLO
	VL-MS-MR002.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S143708AbRAHOde>; Mon, 8 Jan 2001 09:33:34 -0500
Message-ID: <3A59CD57.6FA72934@videotron.ca>
Date: Mon, 08 Jan 2001 09:23:19 -0500
From: Martin Laberge <mlsoft@videotron.ca>
Organization: MLSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.4.0 - sndstat not present
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i installed 2.4.0 last week and all worked well on my amd-K6-350
i use a cheap sound card since 2.0.36 and it always worked well too.
it work well now in 2.4.0, BUT , /dev/sndstat report me <no such file or
directory>
and /proc/sound (as noted in documentation) does not exist...

the sound work well, but i cant verify the existence of the driver with
sndstat anymore

could someone tell me if i should have done some additionnal
configuration to see
appear the /proc/sound or to enable /dev/sndstat...

maybe is it another method now in 2.4 to see the sound status...

Best Wishes to all of you for the new year...

Martin Laberge
mlsoft@videotron.ca





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
