Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132862AbRDUTmi>; Sat, 21 Apr 2001 15:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132864AbRDUTm3>; Sat, 21 Apr 2001 15:42:29 -0400
Received: from huizehofstee.xs4all.nl ([194.109.241.183]:49160 "EHLO
	server.hofstee") by vger.kernel.org with ESMTP id <S132863AbRDUTmT>;
	Sat, 21 Apr 2001 15:42:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Victor Julien <v.p.p.julien@let.rug.nl>
Organization: Huize Hofstee
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3+ sound distortion
Date: Sat, 21 Apr 2001 21:40:30 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.05.10104211159030.5218-100000@cosmic.nrg.org>
In-Reply-To: <Pine.LNX.4.05.10104211159030.5218-100000@cosmic.nrg.org>
MIME-Version: 1.0
Message-Id: <01042121403000.00436@victor>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That did not help. The distortion is no stuttering, but noise in the music. 
It's not specific to xmms, freeamp and xine also have the noise. The noise 
reminds me of years ago when my father used a electric shaver witch gave 
noise in the sound of my radio. Maybe that can give you an idea about the 
sort of noise.

The changelog of 2.4.3 said that there were via-chipset-fixes undone, could 
this be a problem of my chipset?

Victor Julien


Please enter my email-adress in the CC.



On Saturday 21 April 2001 21:05, you wrote:
> On Sat, 21 Apr 2001, Victor Julien wrote:
> > I have a problem with kernels higher than 2.4.2, the sound distorts when
> > playing a song with xmms while the seti@home client runs. 2.4.2 did not
> > have this problem. I tried 2.4.3, 2.4.4-pre5 and 2.4.3-ac11. They al
> > showed the same problem.
>
> Try running xmms as root with the "Use realtime priority when available"
> option checked.  If the distortion is because xmms isn't getting enough
> CPU time, then running it at a realtime priority will fix it.
>
> Nigel Gamble                                    nigel@nrg.org
> Mountain View, CA, USA.                         http://www.nrg.org/
>
> MontaVista Software                             nigel@mvista.com
