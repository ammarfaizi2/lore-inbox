Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272313AbRH3QVn>; Thu, 30 Aug 2001 12:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272312AbRH3QVd>; Thu, 30 Aug 2001 12:21:33 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:37905 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S272315AbRH3QV1>;
	Thu, 30 Aug 2001 12:21:27 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200108301621.UAA05134@ms2.inr.ac.ru>
Subject: Re: tcp connection hangs on connect
To: val@nmt.edu (Val Henson)
Date: Thu, 30 Aug 2001 20:21:16 +0400 (MSK DST)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010829195259.B11544@boardwalk> from "Val Henson" at Aug 29, 1 07:53:02 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> :) I was hoping Alexey would respond with "Oh yeah, here's that patch,

Your hopes were groundless.
Actually, you could change subject, this apparently has nothing
to do with your problem and this is misleading.

I have no idea what happens in your case, apparently, retransmission
timer is lost on sender, which is absolutely impossible. :-)
Well, send me cat of /proc/tcp after the stall happened.

Alexey
