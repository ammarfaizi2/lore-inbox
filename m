Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317129AbSFBFM7>; Sun, 2 Jun 2002 01:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317130AbSFBFM6>; Sun, 2 Jun 2002 01:12:58 -0400
Received: from adsl-66-136-199-111.dsl.austtx.swbell.net ([66.136.199.111]:45698
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S317129AbSFBFM6>; Sun, 2 Jun 2002 01:12:58 -0400
Subject: Re: P4 hyperthreading
From: Austin Gonyou <austin@digitalroadkill.net>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Louis Garcia <louisg00@bellsouth.net>,
        William Lee Irwin III <wli@holomorphy.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206011949340.976-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: http://www.digitalroadkill.net
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 02 Jun 2002 00:12:28 -0500
Message-Id: <1022994748.19674.0.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know if the P4 Xeon's use HT as well, or is it mainly for UP
DP boxes?



On Sat, 2002-06-01 at 22:04, Davide Libenzi wrote:
> On 1 Jun 2002, Louis Garcia wrote:
> 
> > I was just thinking about that. Do you now if this has a real speed
> > improvement?
> 
> intel claims up to 30-40% but i've never tried it. the bottleneck is that
> they share fsb and cache but in any case having an extra exec-path might
> help more than demage. this is for your sleepless nights :
> 
> http://www.intel.com/technology/itj/2002/volume06issue01/art01_hyper/vol6iss1_art01.pdf
> 
> 
> 
> 
> - Davide
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
