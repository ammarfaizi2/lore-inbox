Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317135AbSFBFaf>; Sun, 2 Jun 2002 01:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317136AbSFBFae>; Sun, 2 Jun 2002 01:30:34 -0400
Received: from mail020.mail.bellsouth.net ([205.152.58.60]:49077 "EHLO
	imf20bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S317135AbSFBFae>; Sun, 2 Jun 2002 01:30:34 -0400
Subject: Re: P4 hyperthreading
From: Louis Garcia <louisg00@bellsouth.net>
To: Austin Gonyou <austin@digitalroadkill.net>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        William Lee Irwin III <wli@holomorphy.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1022994748.19674.0.camel@UberGeek>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Jun 2002 01:23:26 -0400
Message-Id: <1022995406.12603.1.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My guess would be yes. Since the P4 and the P4 Xeon is the same core
chip. The Xeon's just have more cache.

--Lou


On Sun, 2002-06-02 at 01:12, Austin Gonyou wrote:
> Does anyone know if the P4 Xeon's use HT as well, or is it mainly for UP
> DP boxes?
> 
> 
> 
> On Sat, 2002-06-01 at 22:04, Davide Libenzi wrote:
> > On 1 Jun 2002, Louis Garcia wrote:
> > 
> > > I was just thinking about that. Do you now if this has a real speed
> > > improvement?
> > 
> > intel claims up to 30-40% but i've never tried it. the bottleneck is that
> > they share fsb and cache but in any case having an extra exec-path might
> > help more than demage. this is for your sleepless nights :
> > 
> > http://www.intel.com/technology/itj/2002/volume06issue01/art01_hyper/vol6iss1_art01.pdf
> > 
> > 
> > 
> > 
> > - Davide
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/


