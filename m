Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132539AbRDWXDg>; Mon, 23 Apr 2001 19:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132537AbRDWXCh>; Mon, 23 Apr 2001 19:02:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1289 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132516AbRDWXAb>; Mon, 23 Apr 2001 19:00:31 -0400
Subject: Re: i810_audio broken?
To: pawel.worach@mysun.com
Date: Tue, 24 Apr 2001 00:02:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3804336226.3622638043@mysun.com> from "Pawel Worach" at Apr 23, 2001 11:48:25 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rpLb-0000j6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was using mpg123 (xmms and c/o does exactly the same)
> if I run it like this Moby sounds very stupid... :)
> [root@whyami mp3]# mpg123 -r 48000 Moby_01.wav.mp3 
> unsupported playback rate: 44100
> Audio device open for 44.1Khz, stereo, 16bit failed
> Trying 44.1Khz, 8bit stereo.
> unsupported sound format: 32
> Audio device open for 44.1Khz, stereo, 8bit failed
> Trying 48Khz, 16bit stereo.

Ok so its trying to do the right thing. Can you describe what it sounds like
better ?

